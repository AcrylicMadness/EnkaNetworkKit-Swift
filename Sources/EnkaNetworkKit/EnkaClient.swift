import Foundation

public final class EnkaClient {
    
    // MARK: - Public Properies
    
    /// Language of the EnkaClient
    let language: EnkaLanguage
    let userAgent: String
    
    // MARK: - Private Properties
    
    private lazy var service: EnkaNetworkService = EnkaNetworkService(clientName: userAgent)
    
    // MARK: - Initialization
    
    /// Creates an instance of EnkaClient that uses OS language.
    /// If OS language is not supported by EnkaNetwork, the 'defaultLanguage' parameter will be used instead
    /// - Parameter defaultLanguage: Language to use if the current OS language is not supported by EnkaNetwork
    public init(userAgent: String, defaultLanguage: EnkaLanguage = .en) {
        let languageManager = EnkaLanguageManager(defaultLanguage: defaultLanguage)
        self.language = languageManager.closestTo(languages: Locale.preferredLanguages)
        self.userAgent = userAgent
    }
    
    /// Creates an instance of EnkaClient that ignores OS language settings and uses the provided language instead
    /// - Parameter language: Language that EnkaClient will use
    public init(userAgent: String, fixedLanguage language: EnkaLanguage) {
        self.language = language
        self.userAgent = userAgent
    }
    
    // MARK: - Methods
    public func fetchUser(uid: String) {
        
    }
    
    public func fetchUser(username: String) {
        
    }
}
