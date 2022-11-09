//
//  GameToolbar.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import SwiftUI

struct GameToolbar<T: Game>: View {
    @ObservedObject var gameController: T
    
    var color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                Button {
                    gameController.showingExitGameAlert = true
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
                Text("\(gameController.userScore)")
                    .font(.title.bold())
                    .foregroundColor(color)
                    .padding()
                    .background(
                        Group {
                            if gameController.userScore < 1000 {
                                Circle()
                            } else {
                                Capsule()
                            }
                        }
                            .foregroundColor(.white)
                    )
            }
            .font(.title2)
            .scaleEffect(gameController.scoreScaleAmount)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Group {
                HStack {
                    Image(systemName: "heart.fill")
                    Text("\(gameController.userLives)")
                }
                .font(.headline)
                .foregroundColor(color)
                .padding(10)
                .background(
                    Capsule()
                        .foregroundColor(.white)
                )
                .scaleEffect(gameController.livesScaleAmount)
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
                    GameToolbar(gameController: CountryGameController(), color: .mayaBlue)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
