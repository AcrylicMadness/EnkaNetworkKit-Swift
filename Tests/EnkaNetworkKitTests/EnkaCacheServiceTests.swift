import XCTest
@testable import EnkaNetworkKit

struct PermanentTestCachable {
    let testProperty: String
}

extension PermanentTestCachable: EnkaCachable {
    var fileName: String {
        "permanent-cache-test"
    }
    
    var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: nil)
    }
}

final class EnkaCacheTests: XCTestCase {
    
    let service: EnkaCacheService = EnkaCacheService()
    
    override func tearDownWithError() throws {
        try service.removeAllPermanentCache()
    }
    
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }

    func testPermanentCacheSave() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: "Hello, Enka!")
        try service.cache(object: testItem)
        XCTAssert(checkIfFileExists(directory: "EnkaNetworkKit-Cache", filename: "\(testItem.fileName).\(testItem.fileExtension)"))
    }
    
    func testPermanentCacheRemoval() throws {
        let testItem: PermanentTestCachable = PermanentTestCachable(testProperty: "Hello, Enka!")
        try service.cache(object: testItem)
        try service.removeAllPermanentCache()
        XCTAssertFalse(checkIfDirectoryExists(directory: "EnkaNetworkKit-Cache"))
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
