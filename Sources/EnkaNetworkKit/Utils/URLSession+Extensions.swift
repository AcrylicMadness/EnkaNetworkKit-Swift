import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func object<T: Codable>(from url: URL, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.data(from: url, delegate: nil)
        let decoder = JSONDecoder() 
        return try decoder.decode(T.self, from: responseData)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.data(for: request, delegate: nil)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
}
