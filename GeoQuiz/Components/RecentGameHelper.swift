//
//  RecentGameHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import SwiftUI

struct RecentGame: View {
    let game: PlayedGame
    let name: String
    let gradient: Gradient
    let symbol: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            RoundedRectangle(cornerRadius: 5)
                .fill(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(width: 35, height: 35)
                .overlay(
                    Image(systemName: symbol)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(5)
                )
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text("\(game.date, format: .dateTime)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(game.score, format: .number) ⭐️")
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
    }
    
    init(game: PlayedGame) {
        self.game = game
        
        switch game.type {
        case .guessTheFlag:
            self.name = GuessTheFlagInfo.name
            self.gradient = GuessTheFlagInfo.gradient
            self.symbol = GuessTheFlagInfo.symbol
        case .guessTheCapital:
            self.name = GuessTheCapitalInfo.name
            self.gradient = GuessTheCapitalInfo.gradient
            self.symbol = GuessTheCapitalInfo.symbol
        case .guessTheCountry:
            self.name = GuessTheCountryInfo.name
            self.gradient = GuessTheCountryInfo.gradient
            self.symbol = GuessTheCountryInfo.symbol
        case .guessThePopulation:
            self.name = GuessThePopulationInfo.name
            self.gradient = GuessThePopulationInfo.gradient
            self.symbol = GuessThePopulationInfo.symbol
        }
    }
}
