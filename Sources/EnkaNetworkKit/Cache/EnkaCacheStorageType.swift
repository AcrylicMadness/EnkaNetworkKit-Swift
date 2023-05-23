import Foundation

/// Enum that determines how cached data should be stored
public enum EnkaCacheStorageType {
    
    static var defaultExpirationTime: TimeInterval = 86400
    
    /// Permanent on-disk storage.
    /// Expiration time determines when the cache will be ivalidated, 24 hours by default.
    /// Directory name determines the subdirecoty for permanent storage, "EnkaNetworkKit-Cache" by default
    case permanent(expirationTime: TimeInterval?)
    
    /// RAM-only cache.
    /// Expiration time determines when the cache will be ivalidated, 10 minutes by default.
    case temporary(expirationTime: TimeInterval?)
    
    /// No cache, data will be loaded every single request
    case none
}
