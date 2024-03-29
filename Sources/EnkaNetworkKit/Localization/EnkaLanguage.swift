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
    case ko
    /// 日本語
    case ja
    /// 中文
    case zhCn
    /// 國語
    case zhTw
    /// Indonesian
    case id
    /// français
    case fr
    /// español
    case es
    /// deutsch
    case de
}

// MARK: - Identifiable
extension EnkaLanguage: Identifiable {
    public var id: String {
        rawValue
    }
}

// MARK: - Codable
extension EnkaLanguage: Codable { }
