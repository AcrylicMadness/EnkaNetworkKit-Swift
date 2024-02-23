import Foundation

struct EnkaLanguageData: Codable {
    let en: [String: String]
    let ru: [String: String]
    let vi: [String: String]
    let th: [String: String]
    
    // TODO: Add the rest of the languageds after I verify that localization works
}
