import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func object<T: Codable>(from url: URL, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await data(from: url)
        let decoder = JSONDecoder() 
        return try decoder.decode(T.self, from: responseData)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
}
