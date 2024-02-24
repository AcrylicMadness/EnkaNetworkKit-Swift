//
//  PlayerInfoView.swift
//  EnkaNetworkKitExpample
//
//  Created by Acrylic M. on 04.05.2023.
//

import EnkaNetworkKit
import SwiftUI

struct PlayerInfoView: View {
    
    // I rarely play Genshin these days but feel free to add me
    @State var uid: String = "720522638"
    @State var playerData: [PlayerData] = []
    @State var isLoading: Bool = false
        
    let enkaClient: EnkaClient = EnkaClient(defaultLanguage: .en, userAgent: "EnkaKitExample-iOS/1.0.0")

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }
    #endif
    
    var body: some View {
        VStack(spacing: 16) {
            Table(playerData) {
                TableColumn("Key") { item in
                    VStack(alignment: .leading) {
                        #if os(iOS)
                        if isCompact {
                            Text(item.value)
                            Text(item.key)
                                .foregroundStyle(.secondary)
                        } else {
                            Text(item.key)
                        }
                        #else
                        Text(item.key)
                        #endif
                    }
                }
                TableColumn("Value", value: \.value)
            }
            HStack {
                Spacer()
                
                TextField("UID", text: $uid)
                
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                        .padding(.horizontal)
                } else {
                    Button {
                        loadPlayerData()
                    } label: {
                        Text("Load")
                            .padding(.horizontal)
                    }
                    .keyboardShortcut(.defaultAction)
                }
               
            }
            .padding()
            .navigationTitle("PlayerData")
        }
    }
    
    func loadPlayerData() {
        
        isLoading = true
        
        Task {
            do {
                let playerInfo = try await enkaClient.playerInfo(forUid: uid)
                DispatchQueue.main.async {
                        isLoading = false
                        playerData.append(PlayerData(key: "Nickname", value: playerInfo.nickname))
                        playerData.append(PlayerData(key: "Signature", value: playerInfo.signature))
                        playerData.append(PlayerData(key: "Adventure Rank", value: "\(playerInfo.adventurRank)"))
                        playerData.append(PlayerData(key: "World level", value: "\(playerInfo.worldLevel)"))
                        playerData.append(PlayerData(key: "Completed achievments", value: "\(playerInfo.finishAchievementNum)"))
                        playerData.append(PlayerData(key: "Abyss", value: "\(playerInfo.abyssFloor)-\(playerInfo.abyssRoom)"))
                    
                    for character in playerInfo.characterList {
                        playerData.append(PlayerData(key: character.name, value: "Level: \(character.level)"))
                    }
                    
                }
            } catch {
                print(error)
            }
        }
    }
}

struct PlayerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInfoView()
    }
}

struct PlayerData: Hashable, Identifiable, Equatable {
    
    var id: String {
        key
    }
    
    let key: String
    let value: String
}
