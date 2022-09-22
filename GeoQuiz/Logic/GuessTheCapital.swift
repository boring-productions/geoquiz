//
//  GuessTheCapital.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation

//class GuessTheCapital: ObservableObject {
    
//    struct Country: Hashable {
//        let capitalName: String
//        let flagSymbol: String
//    }
//
//    let countries: [String: Country]
//    var countriesAsked = [String: Country]()
//
//    @Published var userScore = 0
//    @Published var userLives = 3
//    @Published var questionCounter = 0
//    @Published var alertTitle = ""
//    @Published var alertMessage = ""
//    @Published var scoreScaleAmount = 1.0
//    @Published var livesScaleAmount = 1.0
//    @Published var showingBuyLivesView = false
//    @Published var showingNoLivesAlert = false
//    @Published var showingWrongAnswerAlert = false
//    @Published var showingEndGameAlert = false
//
//    @Published var userChoices = [String: Country]()
//    @Published var countryNameAsked = ""
//
//    init() {
//        let flags: CountryFlags = load("CountryFlags.json")
//        let capitals: CountryCapitals = load("CountryCapitals.json")
//
//        var countries = [String: Country]()
//
//        for country in capitals.countries {
//            let countryName = country.key
//            let capitalName = country.value
//
//            if let flagSymbol = flags.countries[countryName] {
//                countries[country.key] = Country(capitalName: capitalName, flagSymbol: flagSymbol)
//            } else {
//                fatalError()
//            }
//        }
//
//        self.countries = countries
//        askQuestion()
//    }
//
//    func askQuestion() {
//        guard questionCounter < countries.count else {
//            self.alertTitle = "Amazing!"
//            self.alertMessage = "You've completed the game."
//            self.showingEndGameAlert = true
//
//            return
//        }
//
//        var userChoices = [String: Country]()
//
//        while userChoices.count < 2 {
//            if let country = countries.randomElement() {
//                userChoices[country.key] = country.value
//            } else {
//                fatalError("Couldn't get a random country")
//            }
//        }
//
//        let countryAsked = countries.first(where: {
//            !userChoices.keys.contains($0.key) &&
//            !countriesAsked.keys.contains($0.key)
//        })
//
//        if let countryAsked = countryAsked {
//            userChoices[countryAsked.key] = countryAsked.value
//            self.countriesAsked[countryAsked.key] = countryAsked.value
//            self.countryNameAsked = countryAsked.key
//        } else {
//            fatalError("Couldn't get countryAsked")
//        }
//
//        self.userChoices = userChoices
//        self.questionCounter += 1
//    }
//
//    func answered(userChoice userCapitalNameGuess: String) {
//        guard let correctCountry = countries[countryNameAsked] else {
//            fatalError("Couln't find \(countryNameAsked) in countries dictionary")
//        }
//
//        guard userLives > 0 else {
//            self.alertTitle = "Not enough lives!"
//            self.alertMessage = "Please buy more lives to keep playing"
//            self.showingNoLivesAlert = true
//
//            return
//        }
//
//        if correctCountry.capitalName == userCapitalNameGuess {
//            hapticSuccess()
//            self.userScore += 1
//            askQuestion()
//        } else {
//            hapticError()
//            self.userLives -= 1
//            self.alertTitle = "Wrong!"
//            self.alertMessage = "The capital of \(countryNameAsked) is \(correctCountry.capitalName). You have \(userLives) lives left"
//            self.showingWrongAnswerAlert = true
//        }
//    }
//}

class GuessTheCapital: ObservableObject {
    
}
