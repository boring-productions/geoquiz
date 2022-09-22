//
//  GuessTheCapitalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 14/9/22.
//

import SwiftUI

struct GuessTheCapitalView: View {
    @Binding var gameName: GameName?
    @StateObject var game = GuessTheCapital()
    
//    var flagSymbol: String {
//        if let countryAsked = game.countries[game.countryNameAsked] {
//            return countryAsked.flagSymbol
//        } else {
//            fatalError("Couldn't find \(game.countryNameAsked) in countries")
//        }
//    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .secondary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                    VStack(spacing: 20) {
//                        GameToolbar(
//                            userScore: $game.userScore,
//                            userLives: $game.userLives,
//                            gameName: $gameName,
//                            showingBuyLivesView: $game.showingBuyLivesView
//                        )

                        Spacer()
                        
//                        FlagImage(flagSymbol: flagSymbol, cornerRadius: 20)
//                            .shadow(radius: 10)
//                            .frame(height: geo.size.height * 0.15)

                        Spacer()

                        HStack {
//                            VStack(alignment: .leading, spacing: 10) {
//                                Text("Question \(game.questionCounter) of \(game.countries.count)")
//                                    .font(.title3)
//
//                                Text("What is the capital of \(game.countryNameAsked)?")
//                                    .font(.title)
//                                    .fontWeight(.semibold)
//                            }
//                            .foregroundColor(.white)

                            Spacer()
                        }

                        VStack {
//                            ForEach(Array(game.userChoices.values), id: \.self) { country in
//                                Button {
//                                    game.answered(userChoice: country.capitalName)
//                                } label: {
//                                    AnswerButton(optionName: country.capitalName, color: .secondary)
//                                        .frame(height: geo.size.height * 0.08)
//                                }
//                            }
                        }
                    }
                    .padding()
            }
        }
        .navigationBarHidden(true)
        
//        .sheet(isPresented: $game.showingBuyLivesView) {
//            BuyLivesModalView()
//        }
//
//        .alert(game.alertTitle, isPresented: $game.showingNoLivesAlert) {
//            Button("Buy lives") { game.showingBuyLivesView = true }
//            Button("Exit", role: .destructive) { gameName = nil }
//            Button("Cancel", role: .cancel) { }
//        } message: {
//            Text(game.alertMessage)
//        }
//        
//        .alert(game.alertTitle, isPresented: $game.showingWrongAnswerAlert) {
//            Button("Continue", role: .cancel) { game.askQuestion() }
//        } message: {
//            Text(game.alertMessage)
//        }
//        
//        .alert(game.alertTitle, isPresented: $game.showingEndGameAlert) {
//            Button("Exit", role: .cancel) { gameName = nil }
//        } message: {
//            Text(game.alertMessage)
//        }
    }
}

struct GuessCapitalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GuessTheCapitalView(gameName: .constant(GameName.guessTheCapital))
        }
    }
}
