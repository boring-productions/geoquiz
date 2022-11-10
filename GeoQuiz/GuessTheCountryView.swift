//
//  GuessTheCountryView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 24/9/22.
//

import SwiftUI

struct GuessTheCountryView: View, GameView {
    @StateObject var gameController = CityGameController()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .tertiary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(gameController: gameController, color: .pinkLavender)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    CityMap(game: gameController)
                        .frame(height: geo.size.height * 0.35)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(gameController.questionCounter) of \(gameController.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("In what country is \(gameController.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 15) {
                            ForEach(Array(gameController.userChoices.keys), id: \.self) { cityName in
                                Button {
                                    gameController.answer(
                                        choice: (key: cityName, value: gameController.data[cityName]!),
                                        wrongMessage: "\(gameController.correctAnswer.key) is located in \(gameController.correctAnswer.value.country)"
                                    ) {
                                        gameController.selector()
                                    }
                                } label: {
                                    AnswerButton(
                                        name: gameController.data[cityName]!.country,
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
        .modifier(GameAlertsModifier(gameController: gameController, gameType: .guessTheCountry, moc: moc))
    }
}

struct GuessTheCountryView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCountryView()
    }
}
