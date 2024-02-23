import Foundation

class EnkaMapper {
    
    var languageData: EnkaLanguageData = EnkaLanguageData.empty
    var targetLanguage: EnkaLanguage = .en
    var characterData: [String: EnkaCharacterDataUnlocalized] = [:]
    
    func localize(playerInfo: EnkaPlayerInfoUnlocalized) throws -> EnkaPlayerInfo {
        try EnkaPlayerInfo(nickname: playerInfo.nickname,
                       signature: playerInfo.signature,
                       worldLevel: playerInfo.worldLevel,
                       adventurRank: playerInfo.level,
                       nameCardId: playerInfo.nameCardId,
                       finishAchievementNum: playerInfo.finishAchievementNum,
                       abyssFloor: playerInfo.towerFloorIndex,
                       abyssRoom: playerInfo.towerLevelIndex,
                       characterList: playerInfo.showAvatarInfoList.map({ try map(avatar: $0) }))
    }
    
    private func map(avatar: EnkaPlayerInfoUnlocalized.EnkaAvatarUnlocalized) throws -> EnkaPlayerInfo.EnkaAvatar {
        guard let avatarUnlocalizedInfo = characterData["\(avatar.avatarId)"] else {
            throw EnkaMapperError.characterIdNotPresent
        }
        
        let localizedName = languageData.localized(string: "\(avatarUnlocalizedInfo.NameTextMapHash)", forLanguage: targetLanguage)
        return EnkaPlayerInfo.EnkaAvatar(name: localizedName, level: avatar.level)
    }
    
}

enum EnkaMapperError: Error {
    case characterIdNotPresent
}
