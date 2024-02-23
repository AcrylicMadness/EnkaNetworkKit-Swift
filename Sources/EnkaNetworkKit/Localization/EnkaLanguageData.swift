import Foundation

struct EnkaLanguageData: Codable {
    let en: [String: String]
    let ru: [String: String]
    let vi: [String: String]
    let th: [String: String]
    let pt: [String: String]
    let ko: [String: String]
    let ja: [String: String]
    let zhCn: [String: String]
    let zhTw: [String: String]
    let id: [String: String]
    let fr: [String: String]
    let es: [String: String]
    let de: [String: String]

    enum CodingKeys: String, CodingKey {
        case en
        case ru
        case vi
        case th
        case pt
        case ko
        case ja
        case id
        case fr
        case es
        case de
        case zhCn = "zh-CN"
        case zhTw = "zh-TW"
    }
}

extension EnkaLanguageData {
    
    static var empty: EnkaLanguageData {
        EnkaLanguageData(en: [:],
                         ru: [:],
                         vi: [:],
                         th: [:],
                         pt: [:],
                         ko: [:],
                         ja: [:],
                         zhCn: [:],
                         zhTw: [:],
                         id: [:],
                         fr: [:],
                         es: [:],
                         de: [:])
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
            return pt[string] ?? string
        case .ko:
            return ko[string] ?? string
        case .ja:
            return ja[string] ?? string
        case .zhCn:
            return zhCn[string] ?? string
        case .zhTw:
            return zhTw[string] ?? string
        case .id:
            return id[string] ?? string
        case .fr:
            return fr[string] ?? string
        case .es:
            return es[string] ?? string
        case .de:
            return de[string] ?? string
        }
    }
}
