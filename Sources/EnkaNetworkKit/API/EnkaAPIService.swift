import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class EnkaAPIService {
    
    // MARK: - Internal Properties
    
    let userAgent: String?
    
    // MARK: - Private Properties
    
    // TODO: Move some of those properties into config?
    private let enkaUrl: URL = URL(string: "https://enka.network/api/")!
    private let characterDataUrl: URL = URL(string: "https://raw.githubusercontent.com/EnkaNetwork/API-docs/master/store/characters.json")!
    private let enkaNetworkKitAgent: String = "EnkaNetworkKit-Swift/0.1.0"
    private lazy var session: URLSession = URLSession(configuration: .default)
    private lazy var cacheService: EnkaCacheService = EnkaCacheService()
    private lazy var languageService: EnkaLanguageService = EnkaLanguageService()
    private let mapper: EnkaMapper = EnkaMapper()
    private var requiresInitialSetup: Bool = true
    
    var language: EnkaLanguage = .en {
        didSet {
            mapper.targetLanguage = language
        }
    }
    
    // MARK: - Initializtion
    
    init(userAgent: String? = nil) {
        self.userAgent = userAgent
    }
    
    // MARK: - Requests
    
    func loadPlayerInfo(withUid uid: String) async throws -> EnkaPlayerInfo {
        try await setupIfNeeded()
        let endpoint: EnkaNetworkEndpoint = .uid(uid: uid, onlyInfo: true)
        let unlocalizedInfo = try await session.object(for: request(forEndpoint: endpoint), withType: EnkaBaseResponse.self).playerInfo
        return try mapper.localize(playerInfo: unlocalizedInfo)
    }

    // MARK: - Private Methods
    
    private func setupIfNeeded() async throws {
        if requiresInitialSetup {
            mapper.characterData = try await loadCharacterData()
            mapper.languageData = try await languageService.loadLocalizations()
            requiresInitialSetup = false
        }
    }
    
    private func loadCharacterData() async throws -> [String: EnkaCharacterDataUnlocalized] {
        try await session.object(from: characterDataUrl, withType: [String: EnkaCharacterDataUnlocalized].self)
    }
    
    private func request(forEndpoint endpoint: EnkaNetworkEndpoint) -> URLRequest {
        
        var request: URLRequest
        
        #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
        if #available(iOS 16, *) {
            let url = enkaUrl.appending(paths: endpoint.endpointPathComponents).appending(queryItems: endpoint.enpointQuery)
            request = URLRequest(url: url)
        } else {
            let url = enkaUrl.appending(paths: endpoint.endpointPathComponents).appending(query: endpoint.enpointQuery)
            request = URLRequest(url: url)
        }
        #else
        let url = enkaUrl.appending(paths: endpoint.endpointPathComponents).appending(query: endpoint.enpointQuery)
        request = URLRequest(url: url)
        #endif
        
        if let userAgent = userAgent {
            request.setValue("\(userAgent) \(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        } else {
            request.setValue("\(enkaNetworkKitAgent)", forHTTPHeaderField: "User-Agent")
        }
        
        return request
    }
}
