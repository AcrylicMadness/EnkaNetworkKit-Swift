import XCTest
@testable import EnkaNetworkKit

final class EnkaNetworkEndpointTests: XCTestCase {
    
    let url: URL = URL(string: "https://example.com")!
    
    func testPaths() throws {
        
        let endpoint = EnkaNetworkEndpoint.uid(uid: "123", onlyInfo: true)
        
        XCTAssertEqual(url.appending(paths: endpoint.endpointPathComponents).appending(query: endpoint.enpointQuery).absoluteString, "https://example.com/uid/123?info")
    }
}
