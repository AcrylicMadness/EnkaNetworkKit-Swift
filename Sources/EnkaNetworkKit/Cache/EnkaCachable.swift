import Foundation

/// Protocol for classes and structures that can be permanently cahced
protocol EnkaCachable: Codable {
    
    /// Computed property to get data representation of the object
    var jsonData: Data { get throws }
    
    /// Filename for permanent storage
    static var fileName: String { get }
    
    /// File extension for permanent storage. 'json' by default
    static var fileExtension: String { get }
    
    /// Defines storage type for the object
    static var storageType: EnkaCacheStorageType { get }
    
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
    
    static var fileExtension: String {
        "encache"
    }
    
    static var storageType: EnkaCacheStorageType {
        .none
    }
    
    static func from(jsonData data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
