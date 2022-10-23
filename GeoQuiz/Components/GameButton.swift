//
//  GameButton.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct GameButton: View {
    let gameInfo: GameInfo
    let isActive: Bool
    
    init(gameType: GameType, isActive: Bool) {
        self.gameInfo = GameInfoController.getInfo(for: gameType)
        self.isActive = isActive
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: gameInfo.gradient,
                    startPoint: .trailing, endPoint: .leading
                )
            )
            .frame(height: 180)
            .frame(maxWidth: 700)
            .overlay {
                ZStack(alignment: .trailing) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: isActive ? gameInfo.symbol : "lock.fill")
                                .font(.headline)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1.5)
                                )
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(gameInfo.level)
                                .font(.callout)
                            
                            Text(gameInfo.name)
                                .font(.title.bold())
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                }
            }
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(gameType: .guessTheFlag, isActive: false)
    }
}
