import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum EnkaNetworkEndpoint {
    case uid(uid: String, onlyInfo: Bool)
}

extension EnkaNetworkEndpoint {
    var endpointPathComponents: [String] {
        switch self {
        case .uid(let uid, _):
            var pathComponents: [String] = ["uid"]
            pathComponents.append(uid)
            return pathComponents
        }
    }
    
    var enpointQuery: [URLQueryItem] {
        switch self {
        case .uid(_, let onlyInfo):
            if onlyInfo {
                return [URLQueryItem(name: "info", value: nil)]
            } else {
                return []
            }
        }
    }
}
