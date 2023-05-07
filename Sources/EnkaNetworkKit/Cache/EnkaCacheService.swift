import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A service to cache request data.
class EnkaCacheService {
    
    let permanentDirectoryName: String
    
    private(set) var cacheSize: Int = 0
    
    private lazy var fileManager: FileManager = FileManager()
    
    private var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private var cacheDirextoryExists: Bool {
        let fileUrl = documentsDirectory.appendingPathComponent(permanentDirectoryName)
        var isDirectory: ObjCBool = true
        return fileManager.fileExists(atPath: fileUrl.path, isDirectory: &isDirectory)
    }
    
    init(permanentDirectoryName: String = "EnkaNetworkKit-Cache") {
        self.permanentDirectoryName = permanentDirectoryName
        cacheSize = evaluateCacheSize()
    }
    
    func cache(object: EnkaCachable) throws {
        let storageType = object.storageType
        switch storageType {
        case .permanent(let expirationTime):
            try savePermanent(object: object, expirationTime: expirationTime)
            cacheSize = evaluateCacheSize()
        case .temporary(_):
            fatalError("Temporary cache not yet implement")
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
    
    /// Method that saves EnkaCachable object on disk.
    /// Creates a dedicated directory (if one doesn't exist already) saves the object as JSON String
    /// into a text file with filename and file extension taken from EnkaCachable protocol implementation
    /// Note that it also inserts expiration date (file creation date + expirationTime) as the first line of the file
    /// - Parameters:
    ///   - object: EnkaCacheble object
    ///   - expirationTime: Time after which the cached object will be invalidated
    private func savePermanent(object: EnkaCachable, expirationTime: TimeInterval?) throws {
        let currentDate: Date = Date()
        let expirationDate: Date = currentDate.addingTimeInterval(expirationTime ?? EnkaCacheStorageType.defaultPermanentExpirationTime)
        let jsonData = try object.jsonData
        guard var jsonString = String(data: jsonData, encoding: .utf8) else {
            throw EnkaCacheError.unableToConvertCachableObjectToString
        }
        jsonString.insert(contentsOf: "\(expirationDate.timeIntervalSince1970)\n", at: jsonString.startIndex)
        try setupCacheDirectory()
        try write(string: jsonString, fileName: object.fileName, fileExtension: object.fileExtension)
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
    /// So this method is called only after any changes to the cached were made.
    /// - Returns: Cache size in bytes
    private func evaluateCacheSize() -> Int {
        let size = try? fileManager.allocatedSizeOfDirectory(at: documentsDirectory.appendingPathComponent(permanentDirectoryName))
        if let size = size {
            return Int(size)
        } else {
            return 0
        }
    }
}
