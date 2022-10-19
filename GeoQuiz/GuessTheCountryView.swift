//
//  GuessTheCountryView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 24/9/22.
//

import SwiftUI

struct GuessTheCountryView: View {
    @StateObject var game = CityGame()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .tertiary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(game: game, color: .pinkLavender)
                    
                    Spacer()
                    
                    CityMap(game: game)
                        .frame(height: geo.size.height * 0.35)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(game.questionCounter) of \(game.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("In what country is \(game.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 15) {
                            ForEach(Array(game.userChoices.keys), id: \.self) { cityName in
                                Button {
                                    game.answer((key: cityName, value: game.data[cityName]!)) {
                                        game.selector()
                                    }
                                } label: {
                                    AnswerButton(
                                        optionName: game.data[cityName]!.country,
                                        color: .blueBell
                                    )
                                    .frame(height: geo.size.height * 0.08)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 500)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(game: game, gameType: .guessTheCountry, moc: moc))
    }
}

struct GuessTheCountryView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCountryView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        GuessTheCountryView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
            .previewDisplayName("iPad Pro (12.9-inch) (5th generation)")
    }
}
