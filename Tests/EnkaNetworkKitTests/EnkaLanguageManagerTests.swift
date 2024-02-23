import XCTest
@testable import EnkaNetworkKit

final class EnkaLanguageManagerTests: XCTestCase {
    
    let languageManager: EnkaLanguageManager = EnkaLanguageManager(defaultLanguage: .en)
    
    func testLanguageParsing() throws {
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en_US"), .en)
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en"), .en)
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en_US_POSIX"), .en)
        XCTAssertNil(languageManager.enkaLanguage(fromLanguage: "notALanguage"))
        XCTAssertNil(languageManager.enkaLanguage(fromLanguage: "not_a_language"))
    }
    
    func testPreferredLanguages() throws {
        XCTAssertEqual(languageManager.closestTo(languages: ["en_US", "ru_RU"]), .en)
        XCTAssertEqual(languageManager.closestTo(languages: ["not_a_language", "ko_KR"]), .ko)
        XCTAssertEqual(languageManager.closestTo(languages: ["zh_Hans_CN"]), .zhCn)
        XCTAssertEqual(languageManager.closestTo(languages: ["zh_Hant_SG"]), .zhCn)
        XCTAssertEqual(languageManager.closestTo(languages: ["zh_Hant_TW"]), .zhTw)
        XCTAssertEqual(languageManager.closestTo(languages: []), languageManager.defaultLanguage)
        XCTAssertEqual(languageManager.closestTo(languages: ["not_a_language", "also_not_a_language"]), languageManager.defaultLanguage)
    }
}
