import Foundation

enum EnkaNetworkEndpoint {
    case uid(uid: String, onlyInfo: Bool)
}

extension EnkaNetworkEndpoint {
    var endpointPathComponents: [String] {
        switch self {
        case .uid(let uid, let onlyInfo):
            var pathComponents: [String] = ["uid"]
            pathComponents.append(uid)
            if onlyInfo {
                pathComponents.append("?info")
            }
            return pathComponents
        }
    }
}
