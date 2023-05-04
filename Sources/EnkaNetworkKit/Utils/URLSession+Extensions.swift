import Foundation

extension URLSession {
    func object<T: Codable>(from url: URL, withType type: T) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T) async throws -> T {
        let (data, _) = try await data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
