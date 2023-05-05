import Foundation

typealias EnkaCharacterId = String

public struct EnkaCharacters {
    
}

// MARK: - Cachable
extension EnkaCharacters: EnkaCachable {
    var fileName: String {
        "characters"
    }
    
    var fileExtension: String {
        "json"
    }
}
