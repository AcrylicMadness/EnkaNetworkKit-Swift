import Foundation

// MARK: - EnkaLanguage

/// Languages that are supported by EnkaNetwork
public enum EnkaLanguage: String {
    /// English
    case en
    /// русский
    case ru
    /// Tiếng Việt
    case vi
    /// ไทย
    case th
    /// português
    case pt
    /// 한국어
    case kr
    /// 日本語
    case jp
    /// 中文
    case zh
    /// Indonesian
    case id
    /// français
    case fr
    /// español
    case es
    /// deutsch
    case de
    /// Taiwan
    case cht
    /// Chinese
    case chs
}

// MARK: - Identifiable
extension EnkaLanguage: Identifiable {
    public var id: String {
        rawValue
    }
}

// MARK: - Codable
extension EnkaLanguage: Codable { }
