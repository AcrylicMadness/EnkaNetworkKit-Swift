import XCTest
@testable import EnkaNetworkKit

final class EnkaLanguageServiceTests: XCTestCase {
    
    func testLocalizationFetch() async throws {
        let service: EnkaLanguageService = EnkaLanguageService()
        let result = try await service.loadLocalizations()
        
        let mostMetaCharacterId = "2360533154"
        let mostMetaCharacterNameEn = "Dehya"
        let mostMetaCharacterNameRu = "Дэхья"
        let mostMetaCharacterNameJa = "ディシア"
        let mostMetaCharacterNameZhCn = "迪希雅"
        
        XCTAssertEqual(result.en[mostMetaCharacterId], mostMetaCharacterNameEn)
        XCTAssertEqual(result.ru[mostMetaCharacterId], mostMetaCharacterNameRu)
        XCTAssertEqual(result.ja[mostMetaCharacterId], mostMetaCharacterNameJa)
        XCTAssertEqual(result.zhCn[mostMetaCharacterId], mostMetaCharacterNameZhCn)
    }
}
