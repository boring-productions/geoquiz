//
//  GameInfoProtocol+Structs.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import Foundation
import SwiftUI

@objc
public enum GameType: Int16 {
    case guessTheFlag, guessTheCapital, guessTheCountry, guessThePopulation
}

protocol GameInfo {
    static var type: GameType { get }
    static var level: String { get }
    static var name: String { get }
    static var symbol: String { get }
    static var gradient: Gradient { get }
    static var numberOfQuestions: Int { get }
}

class GuessTheFlagInfo: GameInfo {
    static let type: GameType = .guessTheFlag
    static let level = "Level 1"
    static let name = "Guess the flag"
    static let symbol = "flag.fill"
    static let gradient: Gradient = .main
    
    static var numberOfQuestions: Int {
        let data: CountryData = load("countries.json")
        return data.countries.count
    }
}

class GuessTheCapitalInfo: GameInfo {
    static let type: GameType = .guessTheFlag
    static let level = "Level 2"
    static let name = "Guess the capital"
    static let symbol = "building.2.fill"
    static let gradient: Gradient = .secondary
    
    static var numberOfQuestions: Int {
        let data: CountryData = load("countries.json")
        return data.countries.count
    }
}

class GuessTheCountryInfo: GameInfo {
    static let type: GameType = .guessTheFlag
    static let level = "Level 3"
    static let name = "Guess the country"
    static let symbol = "globe.americas.fill"
    static let gradient: Gradient = .tertiary
    
    static var numberOfQuestions: Int {
        let data: CityData = load("cities.json")
        return data.cities.count
    }
}

class GuessThePopulationInfo: GameInfo {
    static let type: GameType = .guessTheFlag
    static let level = "Level 4"
    static let name = "Guess the population"
    static let symbol = "person.fill"
    static let gradient: Gradient = .quaternary
    
    static var numberOfQuestions: Int {
        let data: CityData = load("cities.json")
        return data.cities.count
    }
}
