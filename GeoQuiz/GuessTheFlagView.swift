//
//  GuessTheFlagView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import SwiftUI

struct GuessTheFlagView: View {
    @Binding var gameName: GameName?
    @StateObject var game = CountryGame()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(spacing: 20) {
                    GameToolbar(game: game, color: .mayaBlue)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(game.questionCounter) of \(game.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("What is the flag of \(game.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ForEach(Array(game.userChoices.keys), id: \.self) { countryName in
                        Button {
                            game.answer((key: countryName, value: game.data[countryName]!))
                        } label: {
                            FlagImage(flagSymbol: game.data[countryName]!.flag, cornerRadius: 20)
                                .shadow(radius: 10)
                                .frame(height: geo.size.height * 0.15)
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(game: game, gameName: $gameName))
        .sheet(isPresented: $game.showingBuyLivesView) {
            BuyLivesModalView()
        }
        
        .sheet(isPresented: $game.showingGameStatsView) {
//            GameStatsModalView(game: game)
        }
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView(gameName: .constant(GameName.guessTheFlag))
    }
}
