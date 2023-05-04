import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class EnkaNetworkService {
    
    // MARK: - Internal Properties
    
    let userAgent: String?
    
    // MARK: - Private Properties
    
    private let enkaUrl: URL = URL(string: "https://enka.network/api/")!
    private let enkaNetworkKitAgent: String = "EnkaNetworkKit-Swift/0.1.0"
    private lazy var session: URLSession = URLSession(configuration: .default)
    private lazy var cacheService: EnkaCacheService = EnkaCacheService(session: session)
    
    // MARK: - Initializtion
    
    init(userAgent: String? = nil) {
        self.userAgent = userAgent
    }
    
    // MARK: - Requests
    
    func loadPlayerInfo(withUid uid: String) async throws -> EnkaPlayerInfo {
        let endpoint: EnkaNetworkEndpoint = .uid(uid: uid, onlyInfo: true)
        return try await session.object(for: request(forEndpoint: endpoint), withType: EnkaBaseResponse.self).playerInfo
    }
    
    func downloadCache() {
        
    }
    
    // MARK: - Private Methods

    private func request(forEndpoint endpoint: EnkaNetworkEndpoint) -> URLRequest {
        
        var request: URLRequest
        
        if #available(iOS 16, *) {
            let url = enkaUrl.appending(paths: endpoint.endpointPathComponents).appending(queryItems: endpoint.enpointQuery)
            request = URLRequest(url: url)
        } else {
            var urlComps = URLComponents(string: enkaUrl.appending(paths: endpoint.endpointPathComponents).absoluteString)!
            urlComps.queryItems = endpoint.enpointQuery
            let url = urlComps.url!
            request = URLRequest(url: url)
        }
        
        if let userAgent = userAgent {
            request.setValue("\(userAgent) \(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        } else {
            request.setValue("\(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        }
        
        return request
    }
}
