import Foundation

/// Protocol for classes and structures that can be permanently cahced
protocol EnkaCachable: Codable {
    
    /// Filename for permanent storage
    var fileName: String { get }
    
    /// File extension for permanent storage. 'json' by default
    var fileExtension: String { get }
    
    /// Computed property to get data representation of the object
    var jsonData: Data { get throws }
    
    /// Defines storage type for the object
    var storageType: EnkaCacheStorageType { get }
    
    /// Shortcut to get Cacheble item from JSON Data
    /// - Parameter data: JSON Data
    /// - Returns: Decoded item
    static func from(jsonData data: Data) throws -> Self
}

extension EnkaCachable {
    var jsonData: Data {
        get throws {
            try JSONEncoder().encode(self)
        }
    }
    
    var fileExtension: String {
        "encache"
    }
    
    var storageType: EnkaCacheStorageType {
        .none
    }
    
    static func from(jsonData data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
