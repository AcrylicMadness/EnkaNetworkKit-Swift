import Foundation

struct EnkaLanguageData: Codable {
    let en: [String: String]
    let ru: [String: String]
    let vi: [String: String]
    let th: [String: String]
    
    // TODO: Add the rest of the languageds after I verify that localization works
    static var empty: EnkaLanguageData {
        EnkaLanguageData(en: [:], ru: [:], vi: [:], th: [:])
    }
    
    func localized(string: String, forLanguage language: EnkaLanguage) -> String {
        switch language {
        case .en:
            return en[string] ?? string
        case .ru:
            return ru[string] ?? string
        case .vi:
            return vi[string] ?? string
        case .th:
            return th[string] ?? string
        case .pt:
            return ""
        case .ko:
            return ""
        case .jp:
            return ""
        case .zh:
            return ""
        case .id:
            return ""
        case .fr:
            return ""
        case .es:
            return ""
        case .de:
            return ""
        case .cht:
            return ""
        case .chs:
            return ""
        }
    }
}
