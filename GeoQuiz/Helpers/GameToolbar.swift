//
//  GameToolbar.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import SwiftUI

struct GameToolbar<T: Game>: View {
    @Binding var gameName: GameName?
    @ObservedObject var game: T
    
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                Button {
                    gameName = nil
                } label: {
                    Image(systemName: "multiply")
                        .padding(10)
                        .background(
                            Circle()
                                .strokeBorder(lineWidth: 2)
                        )
                }
            }
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                Text("\(game.userScore)")
                    .padding()
                    .background(
                        Circle()
                            .strokeBorder(lineWidth: 3)
                    )
            }
            .foregroundColor(.white)
            .font(.title2)
            .scaleEffect(game.scoreScaleAmount)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Group {
                Button {
                    game.showingBuyLivesView = true
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("\(game.userLives)")
                    }
                    .padding(10)
                    .background(
                        Capsule()
                            .strokeBorder(lineWidth: 2)
                    )
                    .scaleEffect(game.livesScaleAmount)
                }
            }
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct GameToolbar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(
                        gameName: .constant(GameName.guessTheFlag),
                        game: GuessTheFlag()
                    )
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
