//
//  RecentGame.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import SwiftUI

struct RecentGame: View {
    let game: PlayedGame
    let gameInfo: GameInfo
    
    init(game: PlayedGame) {
        self.game = game
        self.gameInfo = GameInfoController.getInfo(for: game.type)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(
                        gradient: gameInfo.gradient,
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(width: 35, height: 35)
                .overlay(
                    Image(systemName: gameInfo.symbol)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(5)
                )
            
            VStack(alignment: .leading) {
                Text(gameInfo.name)
                    .font(.headline)
                
                Text("\(game.date ?? Date(), format: .dateTime)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(game.score, format: .number) ⭐️")
                .font(.headline)
        }
    }
}
