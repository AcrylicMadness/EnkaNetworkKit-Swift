import Foundation

public final class EnkaClient {
    
    /// Language of the EnkaClient
    let language: EnkaLanguage
    
    // MARK: - Initialization
    
    /// Creates an instance of EnkaClient that uses OS language.
    /// If OS language is not supported by EnkaNetwork, the 'defaultLanguage' parameter will be used instead
    /// - Parameter defaultLanguage: Language to use if the current OS language is not supported by EnkaNetwork
    init(defaultLanguage: EnkaLanguage = .en) {
        let languageManager = EnkaLanguageManager(defaultLanguage: defaultLanguage)
        self.language = languageManager.closestTo(languages: Locale.preferredLanguages)
    }
    
    /// Creates an instance of EnkaClient that ignores OS language settings and uses the provided language instead
    /// - Parameter language: Language that EnkaClient will use
    init(fixedLanguage language: EnkaLanguage) {
        self.language = language
    }
}
