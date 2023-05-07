import Foundation

typealias EnkaCharacterId = String

public struct EnkaCharacters {
    let testProperty: String
}

// MARK: - Cachable
extension EnkaCharacters: EnkaCachable {
    var fileName: String {
        "characters"
    }
    
    var storageType: EnkaCacheStorageType {
        .permanent(expirationTime: nil)
    }
}
