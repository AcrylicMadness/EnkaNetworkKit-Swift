import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
extension URLSession {
    func object<T: Codable>(from url: URL, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
}
#else
/// Defines the possible errors
public enum URLSessionAsyncErrors: Error {
    case invalidUrlResponse, missingResponseData
}

public extension URLSession {
    
    /// A reimplementation of `URLSession.shared.data(from: url)` required for Linux & Windows
    ///
    /// - Parameter url: The URL for which to load data.
    /// - Returns: Data and response.
    ///
    /// - Usage:
    ///
    ///     let (data, response) = try await URLSession.shared.asyncData(from: url)
    func asyncData(from url: URL) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: URLSessionAsyncErrors.invalidUrlResponse)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: URLSessionAsyncErrors.missingResponseData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
    
    /// A reimplementation of `URLSession.shared.data(for: request)` required for Linux & Windows
    ///
    /// - Parameter request: Request for which to load data.
    /// - Returns: Data and response.
    ///
    /// - Usage:
    ///
    ///     let (data, response) = try await URLSession.shared.asyncData(from: url)
    func asyncData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: URLSessionAsyncErrors.invalidUrlResponse)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: URLSessionAsyncErrors.missingResponseData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
    
    func object<T: Codable>(from url: URL, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.asyncData(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
    
    func object<T: Codable>(for request: URLRequest, withType type: T.Type) async throws -> T {
        let (responseData, _) = try await self.asyncData(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: responseData)
    }
}
#endif
