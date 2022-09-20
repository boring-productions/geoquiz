//
//  GuessTheFlag.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import Foundation

class GuessTheFlag: Game, ObservableObject {
    let countries: [String: String]
    var countriesAsked = [String: String]()
    
    @Published var userScore = 0
    @Published var userLives = 3
    @Published var questionCounter = 0
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showingBuyLivesView = false
    @Published var showingNoLivesAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingEndGameAlert = false
    
    @Published var userChoices = [String: String]()
    @Published var countryNameAsked = ""
    
    init() {
        let flags: CountryFlags = load("CountryFlags.json")
        self.countries = flags.countries
        askQuestion()
    }
    
    func askQuestion() {
        guard questionCounter < countries.count else {
            self.alertTitle = "Amazing!"
            self.alertMessage = "You've completed the game."
            self.showingEndGameAlert = true
            
            return
        }
        
        var userChoices = [String: String]()
        
        while userChoices.count < 2 {
            if let country = countries.randomElement() {
                userChoices[country.key] = country.value
            } else {
                fatalError("Couldn't get a random country")
            }
        }
        
        let countryAsked = countries.first(where: {
            !userChoices.keys.contains($0.key) &&
            !countriesAsked.keys.contains($0.key)
        })
        
        if let countryAsked = countryAsked {
            userChoices[countryAsked.key] = countryAsked.value
            self.countriesAsked[countryAsked.key] = countryAsked.value
            self.countryNameAsked = countryAsked.key
        } else {
            fatalError("Couldn't get countryAsked")
        }
        
        self.userChoices = userChoices
        self.questionCounter += 1
    }
    
    func answered(userChoice userFlagSymbolGuess: String) {
        guard let correctFlagSymbolAnswer = countries[countryNameAsked] else {
            fatalError("Couln't find \(countryNameAsked) in countries dictionary")
        }
        
        guard userLives > 0 else {
            self.alertTitle = "Not enough lives!"
            self.alertMessage = "Please buy more lives to keep playing"
            self.showingNoLivesAlert = true

            return
        }
        
        if correctFlagSymbolAnswer == userFlagSymbolGuess {
            hapticSuccess()
            self.userScore += 1
            askQuestion()
        } else {
            hapticError()
            self.userLives -= 1
            self.alertTitle = "Wrong!"
            self.alertMessage = "That's not the flag of \(countryNameAsked). You have \(userLives) lives left"
            self.showingWrongAnswerAlert = true
        }
    }
}
