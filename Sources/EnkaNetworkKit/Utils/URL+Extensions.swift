import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
    func appending(paths: [String]) -> URL {
        var url = self
        for path in paths {
            url = url.appendingPathComponent(path)
        }
        return url
    }
}
