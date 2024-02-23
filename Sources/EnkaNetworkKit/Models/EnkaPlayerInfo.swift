import Foundation

// MARK: - Public localized info

public struct EnkaPlayerInfo: Codable {
    
    // TODO: Add custom coding keys to allow for more descriptive propery names
    
    /// In-game username
    public let nickname: String
    
    /// In-game signature
    public let signature: String
    
    /// Current world level
    public let worldLevel: Int
    
    /// Adventure rank
    public let adventurRank: Int
    
    /// Namecard ID
    public let nameCardId: Int
    
    /// Number of completed achivments
    public let finishAchievementNum: Int
    
    /// Current abyss floor
    public let abyssFloor: Int
    
    /// Current abyss room
    public let abyssRoom: Int
    
    public let characterList: [EnkaAvatar]
    
    public struct EnkaAvatar: Codable {
        public let name: String
        public let level: Int
    }
}

// MARK: - Internal unlocalized DTO

struct EnkaPlayerInfoUnlocalized: Codable {
    /// In-game username
    let nickname: String
    
    /// In-game signature
    let signature: String
    
    /// Current world level
    let worldLevel: Int
    
    /// Adventure rank
    let level: Int
    
    /// Namecard ID
    let nameCardId: Int
    
    /// Number of completed achivments
    let finishAchievementNum: Int
    
    /// Current abyss floor
    let towerFloorIndex: Int
    
    /// Current abyss room
    let towerLevelIndex: Int
    
    let showAvatarInfoList: [EnkaAvatarUnlocalized]
    
    struct EnkaAvatarUnlocalized: Codable {
        let avatarId: Int
        let level: Int
    }
}
