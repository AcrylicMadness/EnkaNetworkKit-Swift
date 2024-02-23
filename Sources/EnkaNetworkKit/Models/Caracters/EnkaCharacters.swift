import Foundation

typealias EnkaCharacterId = String

public struct EnkaCharacters {
    let testProperty: String
}

// MARK: - Cachable
extension EnkaCharacters: EnkaCachable {
    
    static var fileName: String {
        "characters"
    }
    
    static var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: nil)
    }
}

struct EnkaCharacterDataUnlocalized: Codable {
    let NameTextMapHash: Int
    
    // characters.json can contain empty entries for some characters
    // I assume these are placeholders for upcoming Traveller kits
    // This workaround is far from the best but works for now
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.NameTextMapHash = (try? container.decode(Int.self, forKey: .NameTextMapHash)) ?? 0
    }
}

public struct EnkaCharacter {
    let name: String
}
