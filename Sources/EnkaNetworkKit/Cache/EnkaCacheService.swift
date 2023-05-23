import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A simple service to cache request data.
/// Can store one object of a certain type at a time.
class EnkaCacheService {
    
    // MARK: - Properties
    
    let permanentDirectoryName: String
    
    private(set) var cacheSize: Int = 0
    private lazy var fileManager: FileManager = FileManager()
    private lazy var temporaryCache: [String: EnkaTemporaryCachedObject] = [:]
    
    private var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private var cacheDirextoryExists: Bool {
        let fileUrl = documentsDirectory.appendingPathComponent(permanentDirectoryName)
        var isDirectory: ObjCBool = true
        return fileManager.fileExists(atPath: fileUrl.path, isDirectory: &isDirectory)
    }
    
    // MARK: - Initialization
    
    init(permanentDirectoryName: String = "EnkaNetworkKit-Cache") {
        self.permanentDirectoryName = permanentDirectoryName
        cacheSize = evaluateCacheSize()
    }
    
    // MARK: - Working with cache
    
    func cache(object: EnkaCachable) throws {
        let storageType = type(of: object).storageType
        switch storageType {
        case .permanent(let expirationTime):
            try saveTemporary(object: object, expirationTime: expirationTime)
            try savePermanent(object: object, expirationTime: expirationTime)
            cacheSize = evaluateCacheSize()
        case .temporary(let expirationTime):
            try saveTemporary(object: object, expirationTime: expirationTime)
        case .none:
            return
        }
    }
    
    func removeAllPermanentCache() throws {
        if cacheDirextoryExists {
            try fileManager.removeItem(at: documentsDirectory.appendingPathComponent(permanentDirectoryName))
            cacheSize = evaluateCacheSize()
        }
    }
    
    // MARK: - Utils
    
    private func saveTemporary(object: EnkaCachable, expirationTime: TimeInterval?) throws {
        let (_, expirationDate) = try prepareForCaching(object: object, expirationTime: expirationTime)
        let cachedObject = EnkaTemporaryCachedObject(expirationDate: expirationDate, object: object)
        temporaryCache["\(type(of: object).fileName).\(type(of: object).fileExtension)"] = cachedObject
    }
    
    private func saveTemporary(object: EnkaCachable, expirationDate: Date) throws {
        let cachedObject = EnkaTemporaryCachedObject(expirationDate: expirationDate, object: object)
        temporaryCache["\(type(of: object).fileName).\(type(of: object).fileExtension)"] = cachedObject
    }
    
    internal func loadTemporary<T: EnkaCachable>(object: T.Type) throws -> T {
        
        let fullFilename: String = "\(object.fileName).\(object.fileExtension)"
        
        guard let cachedObject = temporaryCache[fullFilename] else {
            throw EnkaCacheError.objectNotInTemporaryCache
        }
        
        if Date() > cachedObject.expirationDate {
            throw EnkaCacheError.cachedObjectExpired
        }
        
        if let cachedObjectOfType = cachedObject.object as? T {
            return cachedObjectOfType
        } else {
            throw EnkaCacheError.badCachedDataFormat
        }
    }
    
    /// Method that saves EnkaCachable object on disk.
    /// Creates a dedicated directory (if one doesn't exist already) saves the object as JSON String
    /// into a text file with filename and file extension taken from EnkaCachable protocol implementation
    /// Note that it also inserts expiration date (file creation date + expirationTime) as the first line of the file
    /// - Parameters:
    ///   - object: EnkaCacheble object
    ///   - expirationTime: Time after which the cached object will be invalidated
    private func savePermanent(object: EnkaCachable, expirationTime: TimeInterval?) throws {
        var (jsonString, expirationDate) = try prepareForCaching(object: object, expirationTime: expirationTime)
        jsonString.insert(contentsOf: "\(expirationDate.timeIntervalSince1970)\n", at: jsonString.startIndex)
        try setupCacheDirectory()
        try write(string: jsonString, fileName: type(of: object).fileName, fileExtension: type(of: object).fileExtension)
    }
    
    /// Loads EnkaCachable object from disk
    /// - Parameter object: Type of an object to load
    /// - Returns: Loaded object
    internal func loadPermanent<T: EnkaCachable>(object: T.Type) throws -> T {
        
        // Trying to load from temporary first
        if let temporaryCached = try? loadTemporary(object: object) {
            return temporaryCached
        }
        
        // Not in temporary cache, loading from disk
        let fileName: String = object.fileName
        let fileExtension: String = object.fileExtension
        
        let fileContents = try String(contentsOf: documentsDirectory.appendingPathComponent(permanentDirectoryName).appendingPathComponent("\(fileName).\(fileExtension)"))
        
        let stringComponents = fileContents.split(separator: "\n")
        
        let expirationDateString = stringComponents[0]
        let objectJsonString = stringComponents[1]
        
        if let interval = TimeInterval(expirationDateString) {
            let expirationDate = Date(timeIntervalSince1970: interval)
            if Date() > expirationDate {
                throw EnkaCacheError.cachedObjectExpired
            }
            
            if let data = objectJsonString.data(using: .utf8) {
                
                // Saving permanent object to temporary cache for permformance optimization
                let object = try T.from(jsonData: data)
                try saveTemporary(object: object, expirationDate: expirationDate)
                return object
            } else {
                throw EnkaCacheError.badCachedDataFormat
            }
        } else {
            throw EnkaCacheError.badCachedDataFormat
        }
    }
    
    private func prepareForCaching(object: EnkaCachable, expirationTime: TimeInterval?) throws -> (json: String, expirationDate: Date) {
        let currentDate: Date = Date()
        let expirationDate: Date = currentDate.addingTimeInterval(expirationTime ?? EnkaCacheStorageType.defaultExpirationTime)
        let jsonData = try object.jsonData
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw EnkaCacheError.unableToConvertCachableObjectToString
        }
        
        return (json: jsonString, expirationDate: expirationDate)
        
    }
    
    private func setupCacheDirectory() throws {
        let fileUrl = documentsDirectory.appendingPathComponent(permanentDirectoryName)
        if !cacheDirextoryExists {
            try fileManager.createDirectory(at: fileUrl, withIntermediateDirectories: false)
        }
    }
    
    private func write(string: String, fileName: String, fileExtension: String) throws {
        let fileUrl: URL = documentsDirectory.appendingPathComponent(permanentDirectoryName).appendingPathComponent("\(fileName).\(fileExtension)")
        try string.write(to: fileUrl, atomically: true, encoding: .utf8)
    }
    
    /// Evaluates cache size.
    /// Since Swift's FileManager does not have any built-in methods to check directory size
    /// we have to manually crawl through all its contents. This proccess can be resource expensive at scale.
    /// So this method is called only after any changes to the cached data were made.
    /// - Returns: Cache size in bytes
    private func evaluateCacheSize() -> Int {
        let attributes = URLFileAttribute(url: documentsDirectory.appendingPathComponent(permanentDirectoryName))
        return Int(attributes.fileSize ?? 0)
    }
}
