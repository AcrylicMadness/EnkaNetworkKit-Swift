import Foundation

extension URLSession {
    func object<T: Codable>(from url: URL, withType type: T.Type) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder() 
        return try decoder.decode(T.self, from: data)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T.Type) async throws -> T {
        let (data, _) = try await data(for: request)
        print(request.url?.absoluteString ?? "")
        print(String(data: data, encoding: .utf8) ?? "")
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
