import XCTest
@testable import EnkaNetworkKit

final class EnkaNetworkEndpointTests: XCTestCase {
    
    let url: URL = URL(string: "https://example.com")!
    
    func testPaths() throws {
        print(url.appending(paths: EnkaNetworkEndpoint.uid(uid: "123123", onlyInfo: true).endpointPathComponents))
    }
}
