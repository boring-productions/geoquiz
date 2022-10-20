//
//  UserProgressHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import SwiftUI

struct ViewTest: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Capsule()
                    .frame(height: 6)
            }
        }
    }
}

struct UserProgress: View {
    let name: String
    let gradient: Gradient
    let score: Int
    let maxScore: Int
    let pctScore: Double
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(name)
                    .font(.headline)
                
                Spacer()
                
                Text("\(score) of \(maxScore)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .foregroundColor(.customBackground)
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                gradient: gradient,
                                startPoint: .trailing, endPoint: .leading
                            )
                        )
                        .frame(width: geo.size.width * pctScore, height: 6)
                }
                .frame(height: geo.size.height)
            }
        }
    }
    
    init(playedGames: FetchedResults<PlayedGame>, gameType: GameType) {
        switch(gameType) {
        case . guessTheFlag:
            self.name = GuessTheFlagInfo.name
            self.gradient = GuessTheFlagInfo.gradient
            self.maxScore = GuessTheFlagInfo.numberOfQuestions
        case .guessTheCapital:
            self.name = GuessTheCapitalInfo.name
            self.gradient = GuessTheCapitalInfo.gradient
            self.maxScore = GuessTheCapitalInfo.numberOfQuestions
        case .guessTheCountry:
            self.name = GuessTheCountryInfo.name
            self.gradient = GuessTheCountryInfo.gradient
            self.maxScore = GuessTheCountryInfo.numberOfQuestions
        case .guessThePopulation:
            self.name = GuessThePopulationInfo.name
            self.gradient = GuessThePopulationInfo.gradient
            self.maxScore = GuessThePopulationInfo.numberOfQuestions
        }
        
        let games = playedGames.filter { $0.type == gameType }
        self.score = Int(games.max { $0.score < $1.score }?.score ?? 0)
        self.pctScore = Double(score) / Double(maxScore)
    }
}
