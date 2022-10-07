//
//  CountryGame.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import Foundation
import AVFAudio

class CountryGame: Game, ObservableObject {
    
    // Define type of generics
    typealias T = CountryModel.CountryData
    
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
    @Published var showingGameOverAlert = false
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingExitGameAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Sound effects
    @Published var player: AVAudioPlayer?
    
    init() {
        let data: CountryModel = load("countries.json")
        self.data = data.countries
        
        if let userSettings = UserDefaults.standard.data(forKey: "UserSettings") {
            if let decodedUserSettings = try? JSONDecoder().decode(UserSettingsModel.self, from: userSettings) {
                userLives = decodedUserSettings.numberOfLives
            }
        }
        
        askQuestion {
            selector()
        }
    }
}

extension CountryGame {
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
        
        // Get question asked (correct answer)
        let correctAnswer = data.first(where: {
            !userChoices.keys.contains($0.key) &&  // Avoid duplicated countries
            !dataAsked.keys.contains($0.key)       // Avoid countries already asked
        })
        
        // Unwrap optional
        if let correctAnswer = correctAnswer {
            userChoices[correctAnswer.key] = correctAnswer.value
            dataAsked[correctAnswer.key] = correctAnswer.value
            self.correctAnswer = correctAnswer
        } else {
            fatalError("Couldn't unwrap optional value")
        }
        
        self.userChoices = userChoices
    }
}
