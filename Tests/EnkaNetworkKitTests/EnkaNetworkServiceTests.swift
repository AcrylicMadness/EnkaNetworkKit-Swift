import XCTest
@testable import EnkaNetworkKit

final class EnkaNetworkServiceTests: XCTestCase {
    
    let uid: String = "720522638"
    
    func testRequest() async throws {
        let service: EnkaAPIService = EnkaAPIService()
        let result = try await service.loadPlayerInfo(withUid: uid)
        print(result)
    }
}
