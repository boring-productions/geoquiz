//
//  GameInfoModel+Protocol.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/10/22.
//

import Foundation
import SwiftUI

protocol GameInfo {
    var type: GameType { get }
    var level: String { get }
    var name: String { get }
    var isPremium: Bool { get }
    var symbol: String { get }
    var gradient: Gradient { get }
    var numberOfQuestions: Int { get }
}

class GameInfoModel {
    static func getInfo(for gameType: GameType) -> GameInfo {
        switch gameType {
        case .guessTheFlag:
            return GuessTheFlagInfo()
        case .guessTheCapital:
            return GuessTheCapitalInfo()
        case .guessTheCountry:
            return GuessTheCountryInfo()
        case .guessThePopulation:
            return GuessThePopulationInfo()
        }
    }
    
    private struct GuessTheFlagInfo: GameInfo {
        let type: GameType = .guessTheFlag
        let level = "Level 1"
        let name = "Guess the flag"
        let isPremium = false
        let symbol = "flag.fill"
        let gradient: Gradient = .main
        
        var numberOfQuestions: Int {
            let data: CountryModel = Bundle.main.decode("countries.json")
            return data.countries.count
        }
    }

    private struct GuessTheCapitalInfo: GameInfo {
        let type: GameType = .guessTheFlag
        let level = "Level 2"
        let name = "Guess the capital"
        let isPremium = false
        let symbol = "building.2.fill"
        let gradient: Gradient = .secondary
        
        var numberOfQuestions: Int {
            let data: CountryModel = Bundle.main.decode("countries.json")
            return data.countries.count
        }
    }

    private struct GuessTheCountryInfo: GameInfo {
        let type: GameType = .guessTheFlag
        let level = "Level 3"
        let name = "Guess the country"
        let isPremium = false
        let symbol = "globe.americas.fill"
        let gradient: Gradient = .tertiary
        
        var numberOfQuestions: Int {
            let data: CityModel = Bundle.main.decode("cities.json")
            return data.cities.count
        }
    }

    private struct GuessThePopulationInfo: GameInfo {
        let type: GameType = .guessTheFlag
        let level = "Level 4"
        let name = "Guess the population"
        let isPremium = false
        let symbol = "person.fill"
        let gradient: Gradient = .quaternary
        
        var numberOfQuestions: Int {
            let data: CityModel = Bundle.main.decode("cities.json")
            return data.cities.count
        }
    }
}
