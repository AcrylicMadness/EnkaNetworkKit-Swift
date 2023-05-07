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
