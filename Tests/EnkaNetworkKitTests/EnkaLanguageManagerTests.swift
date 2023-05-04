import XCTest
@testable import EnkaNetworkKit

final class EnkaLanguageManagerTests: XCTestCase {
    
    let languageManager: EnkaLanguageManager = EnkaLanguageManager(defaultLanguage: .en)
    
    func testLanguageParsing() throws {
        
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en_US"),
                       .en)
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en"),
                       .en)
        XCTAssertEqual(languageManager.enkaLanguage(fromLanguage: "en_US_POSIX"),
                       .en)
        XCTAssertNil(languageManager.enkaLanguage(fromLanguage: "notALanguage"))
        XCTAssertNil(languageManager.enkaLanguage(fromLanguage: "not_A_Language"))
    }
    
    func testPreferredLanguages() throws {
        XCTAssertEqual(languageManager.closestTo(languages: ["ru_RU", "en_RU"]), .ru)
        XCTAssertEqual(languageManager.closestTo(languages: []), languageManager.defaultLanguage)
        XCTAssertEqual(languageManager.closestTo(languages: ["notALanguage", "also_notALanguage"]), languageManager.defaultLanguage)
    }
    
}
