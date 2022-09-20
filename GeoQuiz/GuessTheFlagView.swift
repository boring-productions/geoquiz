//
//  GuessTheFlagView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import SwiftUI

struct GuessTheFlagView: View {
    @Binding var gameName: GameName?
    @StateObject var game = GuessTheFlag()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader{ geo in
                VStack(spacing: 20) {
                    GameToolbar(
                        userScore: $game.userScore,
                        userLives: $game.userLives,
                        gameName: $gameName,
                        showingBuyLivesView: $game.showingBuyLivesView
                    )
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(game.questionCounter) of \(game.countries.count)")
                                .font(.title3)

                            Text("What is the flag of \(game.countryNameAsked)?")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)

                        Spacer()
                    }
                    
                    Spacer()
                    
                    ForEach(Array(game.userChoices.values), id: \.self) { flagSymbol in
                        Button {
                            game.answered(userChoice: flagSymbol)
                        } label: {
                            FlagImage(flagSymbol: flagSymbol, cornerRadius: 20)
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
        
        .sheet(isPresented: $game.showingBuyLivesView) {
            BuyLivesModal()
        }

        .alert(game.alertTitle, isPresented: $game.showingNoLivesAlert) {
            Button("Buy lives") { game.showingBuyLivesView = true }
            Button("Exit", role: .destructive) { gameName = nil }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(game.alertMessage)
        }
        
        .alert(game.alertTitle, isPresented: $game.showingWrongAnswerAlert) {
            Button("Continue", role: .cancel) { game.askQuestion() }
        } message: {
            Text(game.alertMessage)
        }
        
        .alert(game.alertTitle, isPresented: $game.showingEndGameAlert) {
            Button("Exit", role: .cancel) { gameName = nil }
        } message: {
            Text(game.alertMessage)
        }
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView(gameName: .constant(GameName.guessTheFlag))
    }
}
