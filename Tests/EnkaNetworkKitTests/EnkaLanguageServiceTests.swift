import XCTest
@testable import EnkaNetworkKit

final class EnkaLanguageServiceTests: XCTestCase {
    
    func testLocalizationFetch() async throws {
        let service: EnkaLanguageService = EnkaLanguageService()
        let result = try await service.loadLocalizations()
        
        let mostMetaCharacterId = "2360533154"
        let mostMetaCharacterNameEn = "Dehya"
        let mostMetaCharacterNameRu = "Дэхья"
        
        XCTAssertEqual(result.en[mostMetaCharacterId], mostMetaCharacterNameEn)
        XCTAssertEqual(result.ru[mostMetaCharacterId], mostMetaCharacterNameRu)
    }
}
