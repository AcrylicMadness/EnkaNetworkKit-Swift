import Foundation

public struct EnkaPlayerInfo: Codable {
    public let nickname: String
    public let signature: String
    public let worldLevel: Int
    public let level: Int
    public let nameCardId: Int
    public let finishAchievementNum: Int
    public let towerFloorIndex: Int
    public let towerLevelIndex: Int
}
