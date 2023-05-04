import XCTest
@testable import EnkaNetworkKit

final class EnkaNetworkEndpointTests: XCTestCase {
    
    let url: URL = URL(string: "https://example.com")!
    
    func testPaths() throws {
        XCTAssertEqual(url.appending(paths: EnkaNetworkEndpoint.uid(uid: "123", onlyInfo: true).endpointPathComponents).absoluteString.removingPercentEncoding,
                       "https://example.com/uid/123/?info")
    }
}
