//
//  GameProgressHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import SwiftUI

struct UserProgress: View {
    private let games: [(key: String, value: GameProgress)]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 10) {
                ForEach(games, id: \.key) { game in
                    HStack {
                        Text(game.key)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(game.value.highestScore) of \(game.value.numberOfQuestions)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    ProgressBar(pctScore: game.value.pctScore, gradient: game.value.gradient)
                    
                    if game.key != games.last!.key {
                        Divider()
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
        )
    }
    
    init(playedGames: FetchedResults<PlayedGame>) {
        let flagGames = playedGames.filter { $0.type == .guessTheFlag }
        let capitalGames = playedGames.filter { $0.type == .guessTheCapital }
        let countryGames = playedGames.filter { $0.type == .guessTheCountry }
        let populationGames = playedGames.filter { $0.type == .guessThePopulation }
        
        self.games = [
            GuessTheFlagInfo.name: GameProgress(
                numberOfQuestions: GuessTheFlagInfo.numberOfQuestions,
                highestScore: Int(flagGames.max { $0.score < $1.score }?.score ?? 0),
                gradient: GuessTheFlagInfo.gradient
            ),
            GuessTheCapitalInfo.name: GameProgress(
                numberOfQuestions: GuessTheCapitalInfo.numberOfQuestions,
                highestScore: Int(capitalGames.max { $0.score < $1.score }?.score ?? 0),
                gradient: GuessTheCapitalInfo.gradient
            ),
            GuessTheCountryInfo.name: GameProgress(
                numberOfQuestions: GuessTheCountryInfo.numberOfQuestions,
                highestScore: Int(countryGames.max { $0.score < $1.score }?.score ?? 0),
                gradient: GuessTheCountryInfo.gradient
            ),
            GuessThePopulationInfo.name: GameProgress(
                numberOfQuestions: GuessThePopulationInfo.numberOfQuestions,
                highestScore: Int(populationGames.max { $0.score < $1.score }?.score ?? 0),
                gradient: GuessThePopulationInfo.gradient
            )
        ].sorted { $0.value.pctScore > $1.value.pctScore }
    }
    
    private struct GameProgress {
        let numberOfQuestions: Int
        let highestScore: Int
        var pctScore: Double {
            Double(highestScore) / Double(numberOfQuestions)
        }
        
        let gradient: Gradient
    }
}
