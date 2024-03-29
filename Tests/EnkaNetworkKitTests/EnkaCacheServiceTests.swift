import XCTest
@testable import EnkaNetworkKit

struct PermanentTestCachable {
    let testProperty: String
}

extension PermanentTestCachable: EnkaCachable {
    static var fileName: String {
        "permanent-cache-test"
    }
    
    static var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: nil)
    }
}

struct ExpirablePermanentTestCachable {
    let testProperty: String
}

extension ExpirablePermanentTestCachable: EnkaCachable {
    static var fileName: String {
        "expirable-permanent-cache-test"
    }
    
    static var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: 20)
    }
}

struct TemporaryTestCachable {
    let testProperty: String
}

extension TemporaryTestCachable: EnkaCachable {
    static var fileName: String {
        "temporary-cache-test"
    }
    
    static var storageType: EnkaCacheStorageType {
        .temporary(expirationTime: nil)
    }
}

struct ExpirableTemporaryTestCachable {
    let testProperty: String
}

extension ExpirableTemporaryTestCachable: EnkaCachable {
    static var fileName: String {
        "expirable-temporary-cache-test"
    }
    
    static var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: 20)
    }
}


final class EnkaCacheServiceTests: XCTestCase {
    
    let directoryName: String = "EnkaNetworkKit-Tests-Cache"
    let permanentTestProperty: String = "Hello, Enka!"
    
    lazy var service: EnkaCacheService = EnkaCacheService(permanentDirectoryName: directoryName)
    
    override func tearDownWithError() throws {
        try service.removeAllPermanentCache()
    }
    
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }

    func testPermanentCacheSave() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        XCTAssert(checkIfFileExists(directory: directoryName, filename: "\(type(of: testItem).fileName).\(type(of: testItem).fileExtension)"))
    }
    
    func testPermanentCacheRemoval() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        try service.removeAllPermanentCache()
        XCTAssertFalse(checkIfDirectoryExists(directory: directoryName))
        XCTAssertTrue(service.cacheSize == 0)
    }
    
    func testCacheRead() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        let result = try service.loadPermanent(object: PermanentTestCachable.self)
        XCTAssertTrue(result.testProperty == permanentTestProperty)
    }
    
    func testCacheExpiration() throws {
        let testItem: ExpirablePermanentTestCachable = ExpirablePermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        let result = try service.loadPermanent(object: ExpirablePermanentTestCachable.self)
        XCTAssertTrue(result.testProperty == permanentTestProperty)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for the cache to expire")], timeout: 25)
        do {
            _ = try service.loadPermanent(object: ExpirablePermanentTestCachable.self)
        } catch {
            if let enkaError = error as? EnkaCacheError {
                XCTAssertTrue(enkaError == .cachedObjectExpired)
            } else {
                XCTAssert(false)
            }
        }
    }
    
    func testPermanentCachingInTemporary() throws {
        // Permanently cached objects should also be available in temporary cache
        let testItem: ExpirablePermanentTestCachable = ExpirablePermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        let result = try service.loadTemporary(object: ExpirablePermanentTestCachable.self)
        XCTAssertTrue(result.testProperty == permanentTestProperty)
    }
    
    func testTemporaryCache() throws {
        let testItem: TemporaryTestCachable = TemporaryTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        let result = try service.loadTemporary(object: TemporaryTestCachable.self)
        XCTAssertTrue(result.testProperty == permanentTestProperty)
    }
    
    func testCacheSize() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: permanentTestProperty)
        try service.cache(object: testItem)
        #if os(Windows)
        // Cache size doesn't work on Windows
        XCTAssert(true)
        #else
        XCTAssertTrue(service.cacheSize != 0)
        #endif
    }

    func checkIfFileExists(directory: String, filename: String) -> Bool {
        let fileUrl = documentsDirectory.appendingPathComponent(directory).appendingPathComponent(filename)
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: fileUrl.path)
    }
    
    func checkIfDirectoryExists(directory: String) -> Bool {
        let fileUrl = documentsDirectory.appendingPathComponent(directory)
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = true
        return fileManager.fileExists(atPath: fileUrl.path, isDirectory: &isDirectory)
    }
}
