import Foundation

public struct PlayerInfo: Codable {
    let nickname: String
    let signature: String
    let worldLevel: Int
    let nameCardId: Int
    let finishAchievementNum: Int
    let towerFloorIndex: Int
    let towerLevelIndex: Int
    let ttl: Int
    let uid: String
}
