//
//  GuessTheFlagView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import SwiftUI

struct GuessTheFlagView: View {
    @StateObject var game = CountryGame()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(game: game, color: .mayaBlue)
                        .padding(.bottom)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Question \(game.questionCounter) of \(game.data.count)")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("What is the flag of")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("\(game.correctAnswer.key)?")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    VStack(spacing: 30) {
                        ForEach(Array(game.userChoices.keys), id: \.self) { countryName in
                            Button {
                                game.answer((key: countryName, value: game.data[countryName]!)) {
                                    game.selector()
                                }
                            } label: {
                                FlagImage(flagSymbol: game.data[countryName]!.flag, cornerRadius: 20)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .strokeBorder(.white, lineWidth: 4)
                                    }
                                    .shadow(radius: 10)
                                    .frame(height: geo.size.height * 0.15)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(game: game))
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        GuessTheFlagView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
            .previewDisplayName("iPad Pro (12.9-inch) (5th generation)")
    }
}
