//
//  GuessTheCapitalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 14/9/22.
//

import SwiftUI

struct GuessTheCapitalView: View {
    @StateObject var game = CountryGame()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .secondary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(spacing: 20) {
                    GameToolbar(game: game, color: .atomicTangerine)
                    
                    Spacer()
                    
                    FlagImage(flagSymbol: game.correctAnswer.value.flag, cornerRadius: 20)
                        .shadow(radius: 10)
                        .frame(height: geo.size.height * 0.15)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(game.questionCounter) of \(game.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("What is the capital of \(game.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(Array(game.userChoices.keys), id: \.self) { countryName in
                            Button {
                                game.answer((key: countryName, value: game.data[countryName]!))
                            } label: {
                                AnswerButton(
                                    optionName: game.data[countryName]!.capital,
                                    color: .chinaPink
                                )
                                .frame(height: geo.size.height * 0.08)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(game: game))
    }
}

struct GuessCapitalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GuessTheCapitalView()
        }
    }
}
