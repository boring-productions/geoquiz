//
//  GameToolbar.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import SwiftUI

struct GameToolbar: View {
    @Binding var userScore: Int
    @Binding var userLives: Int
    @Binding var gameName: GameName?
    @Binding var showingBuyLivesView: Bool
    
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
                Text("\(userScore)")
                    .padding()
                    .background(
                        Circle()
                            .strokeBorder(lineWidth: 3)
                    )
            }
            .foregroundColor(.white)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Group {
                Button {
                    showingBuyLivesView = true
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("\(userLives)")
                    }
                    .padding(10)
                    .background(
                        Capsule()
                            .strokeBorder(lineWidth: 2)
                    )
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
                        userScore: .constant(0),
                        userLives: .constant(6),
                        gameName: .constant(.guessTheFlag), showingBuyLivesView: .constant(false)
                    )
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
