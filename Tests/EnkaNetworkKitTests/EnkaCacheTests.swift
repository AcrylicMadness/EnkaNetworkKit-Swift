import XCTest
@testable import EnkaNetworkKit

final class EnkaCacheTests: XCTestCase {

    let cache: EnkaCacheService = EnkaCacheService(session: URLSession.shared)
    
    func testCacheSetup() throws {
        cache.setupCache()
    }

}
