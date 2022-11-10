//
//  CountryGameController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import Foundation
import AVFAudio

class CountryGameController: Game, ObservableObject {
    
    // Define type of generics
    typealias T = CountryModel.Country
    
    var data: [String: T]
    var dataAsked = [String: T]()
    
    // Data
    @Published var correctAnswer = (
        key: String(),
        value: T(flag: String(), currency: String(), population: Int(), capital: String())
    )
    
    // User
    @Published var userChoices = [String: T]()
    @Published var userScore = 0
    @Published var userLives = 3
    @Published var correctAnswers = [String: T]()
    @Published var wrongAnswers = [String: T]()
    
    // Alerts
    @Published var alertTitle = String()
    @Published var alertMessage = String()
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingExitGameAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Sound effects
    @Published var player: AVAudioPlayer?
    
    init() {
        let data: CountryModel = Bundle.main.decode("countries.json")
        let shuffledCountries = data.countries.shuffled().prefix(100)
        
        var countries = [String: T]()
        for shuffledCountry in shuffledCountries {
            countries[shuffledCountry.key] = shuffledCountry.value
        }
        
        self.data = countries
        
        let user = UserController()
        userLives = user.data.numberOfLives
        
        if let userData = UserDefaults.standard.data(forKey: "UserData") {
            if let decodedUserData = try? JSONDecoder().decode(UserDataModel.self, from: userData) {
                userLives = decodedUserData.numberOfLives
            }
        }
        
        askQuestion {
            selector()
        }
    }
}

extension CountryGameController {
    func selector() {
        
        // Get random choices
        var userChoices = [String: T]()
        
        while userChoices.count < 2 {
            if let choice = data.randomElement() {
                userChoices[choice.key] = choice.value
            } else {
                fatalError("Couldn't get a random value from data")
            }
        }
        
        // Get correct answer
        let randomCountryKeys = data.keys.shuffled()
        
        let correctCountryKey = randomCountryKeys.first(where: {
            !userChoices.keys.contains($0) &&   // Avoid duplicated countries
            !dataAsked.keys.contains($0)        // Avoid countries already asked
        })
        
        // Unwrap correct answer
        if let correctCountryKey = correctCountryKey {
            let correctCountryValue = data[correctCountryKey]!
            
            userChoices[correctCountryKey] = correctCountryValue
            dataAsked[correctCountryKey] = correctCountryValue
            
            let correctAnswer = (key: correctCountryKey, value: correctCountryValue)
            self.correctAnswer = correctAnswer
        } else {
            fatalError("Couldn't unwrap optional value")
        }
        
        self.userChoices = userChoices
    }
}
