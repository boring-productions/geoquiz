//
//  GameToolbar.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import SwiftUI

struct GameToolbar<T: Game>: View {
    @ObservedObject var game: T
    
    var color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                Button {
                    game.showingExitGameAlert = true
                } label: {
                    Image(systemName: "multiply")
                        .font(.headline)
                        .foregroundColor(color)
                        .padding(10)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                        )
                }
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                Text("\(game.userScore)")
                    .font(.title.bold())
                    .foregroundColor(color)
                    .padding()
                    .background(
                        Group {
                            if game.userScore < 1000 {
                                Circle()
                            } else {
                                Capsule()
                            }
                        }
                            .foregroundColor(.white)
                    )
            }
            .font(.title2)
            .scaleEffect(game.scoreScaleAmount)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Group {
                HStack {
                    Image(systemName: "heart.fill")
                    Text("\(game.userLives)")
                }
                .font(.headline)
                .foregroundColor(color)
                .padding(10)
                .background(
                    Capsule()
                        .foregroundColor(.white)
                )
                .scaleEffect(game.livesScaleAmount)
            }
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
                    GameToolbar(game: CountryGameController(), color: .mayaBlue)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
