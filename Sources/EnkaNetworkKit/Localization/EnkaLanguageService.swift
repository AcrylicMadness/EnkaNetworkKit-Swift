import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class EnkaLanguageService {
    
    // TODO: Move this to global config
    private let localeUrl: URL = URL(string: "https://raw.githubusercontent.com/EnkaNetwork/API-docs/master/store/loc.json")!
    private let enkaNetworkKitAgent: String = "EnkaNetworkKit-Swift/0.1.0"
    private lazy var session: URLSession = URLSession(configuration: .default)
    
    func loadLocalizations() async throws -> EnkaLanguageData {
        try await session.object(from: localeUrl, withType: EnkaLanguageData.self)
    }
}
