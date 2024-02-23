import Foundation

struct EnkaLanguageManager {
    
    // MARK: - Properties
    
    /// Default language
    var defaultLanguage: EnkaLanguage
    
    // MARK: - Methods
    
    /// Returns EnkaLanguage from provided languiage descriptor
    /// - Parameter language: Language descriptor in the format of 'en_US', 'en-US' or 'en'
    /// - Returns: Corresponding EnkaLanguage or nil if not found
    func enkaLanguage(fromLanguage language: String) -> EnkaLanguage? {
        
        let prefix = language.prefix(2)
        
        // TODO: Add extra logic to handle zh-TW and zh-CN separately
        if let enkaLanguage = EnkaLanguage(rawValue: String(prefix)) {
            return enkaLanguage
        } else {
            return nil
        }
    }
    
    /// Iterates through provided languages and returns first match.
    /// - Parameter languages: Language descriptors in the format of 'en_US' or 'en'
    /// - Returns: First matched language. If no matches were found , returns default language
    func closestTo(languages: [String]) -> EnkaLanguage {
        for providedLanguage in languages {
            if let enkaLanguage = enkaLanguage(fromLanguage: providedLanguage) {
                return enkaLanguage
            }
        }
        return defaultLanguage
    }
}
