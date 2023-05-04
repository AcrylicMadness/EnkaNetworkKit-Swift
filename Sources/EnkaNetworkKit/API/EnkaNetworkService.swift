import Foundation

class EnkaNetworkService {
    
    // MARK: - Internal Properties
    
    let userAgent: String?
    
    // MARK: - Private Properties
    
    private let enkaUrl: URL = URL(string: "https://enka.network/api/")!
    private let enkaNetworkKitAgent: String = "EnkaNetworkKit-Swift/0.1.0"
    private lazy var session: URLSession = URLSession(configuration: .default)
    
    // MARK: - Initializtion
    
    init(userAgent: String? = nil) {
        self.userAgent = userAgent
    }
    
    // MARK: - Requests
    
    func loadPlayerInfo(withUid uid: String) async throws -> PlayerInfo {
        let endpoint: EnkaNetworkEndpoint = .uid(uid: uid, onlyInfo: true)
        return try await session.object(for: request(forEndpoint: endpoint), withType: BaseResponse.self).playerInfo
    }
    
    // MARK: - Private Methods

    private func request(forEndpoint endpoint: EnkaNetworkEndpoint) -> URLRequest {
        let url: URL = enkaUrl.appending(paths: endpoint.endpointPathComponents).appending(queryItems: endpoint.enpointQuery)
        var request: URLRequest = URLRequest(url: url)
        
        if let userAgent = userAgent {
            request.setValue("\(userAgent) \(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        } else {
            request.setValue("\(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        }
        
        return request
    }
}
