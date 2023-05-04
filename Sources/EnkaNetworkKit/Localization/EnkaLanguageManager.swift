import Foundation

struct EnkaLanguageManager {
    
    // MARK: - Properties
    
    /// Default language
    var defaultLanguage: EnkaLanguage
    
    // MARK: - Methods
    
    /// Returns EnkaLanguage from provided languiage descriptor
    /// - Parameter language: Language descriptor in the format of 'en_US' or 'en'
    /// - Returns: Corresponding EnkaLanguage or nil if not found
    func enkaLanguage(fromLanguage language: String) -> EnkaLanguage? {
        if let languageShort = language.split(separator: "_").first {
            if let enkaLanguage = EnkaLanguage(rawValue: String(languageShort)) {
                return enkaLanguage
            } else {
                return nil
            }
        } else {
            if let enkaLanguage = EnkaLanguage(rawValue: language) {
                return enkaLanguage
            } else {
                return nil
            }
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
