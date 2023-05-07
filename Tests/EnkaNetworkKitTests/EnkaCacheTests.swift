import XCTest
@testable import EnkaNetworkKit

final class EnkaCacheTests: XCTestCase {
    
    let service: EnkaCacheService = EnkaCacheService()
    
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func testPermanentCacheSave() throws {
        let characters: EnkaCharacters = EnkaCharacters(testProperty: "Hello, Enka!")
        try service.cache(object: characters)
        checkIfFileExists(directory: "EnkaNetworkKit-Cache", filename: "characters.encache")
    }
    
    
    
    func checkIfFileExists(directory: String, filename: String) {
        let fileUrl = documentsDirectory.appendingPathComponent(directory).appendingPathComponent(filename)
        let fileManager = FileManager.default
        XCTAssert(fileManager.fileExists(atPath: fileUrl.path))
    }
}
