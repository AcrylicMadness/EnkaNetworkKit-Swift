import Foundation

enum EnkaCacheError: Error {
    case unableToConvertCachableObjectToString
    case badCachedDataFormat
    case cachedObjectExpired
}
