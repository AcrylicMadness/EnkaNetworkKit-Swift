import Foundation

public struct EnkaPlayerInfo: Codable {
    
    // TODO: Add custom coding keys to allow for more descriptive propery names
    
    /// In-game username
    public let nickname: String
    
    /// In-game signature
    public let signature: String
    
    /// Current world level
    public let worldLevel: Int
    
    /// Adventure rank
    public let level: Int
    
    /// Namecard ID
    public let nameCardId: Int
    
    /// Number of completed achivments
    public let finishAchievementNum: Int
    
    /// Current abyss floor
    public let towerFloorIndex: Int
    
    /// Current abyss room
    public let towerLevelIndex: Int
}
