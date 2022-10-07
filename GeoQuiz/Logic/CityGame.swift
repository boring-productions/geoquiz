//
//  CityGame.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation
import AVFAudio

class CityGame: Game, ObservableObject {
    
    // Define type of generics
    typealias T = CityModel.CityData
    
    var data: [String: T]
    var dataAsked = [String: T]()
    
    // Data
    @Published var correctAnswer = (
        key: String(),
        value: T(country: String(), lat: Double(), lon: Double())
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
        let data: CityModel = load("cities.json")
        self.data = data.cities
        askQuestion {
            selector()
        }
    }
}

extension CityGame {
    func selector() {
        
        // Get random choices
        var userChoices = [String: T]()
        
        while userChoices.count < 2 {
            if let choice = data.randomElement() {
                let userChoicesCountry = userChoices.map { $0.value.country }
                
                if !userChoicesCountry.contains(choice.value.country) {
                    userChoices[choice.key] = choice.value
                }
            } else {
                fatalError("Couldn't get a random value from data")
            }
        }
        
        // Get question asked (correct answer)
        let userChoicesCountry = userChoices.map { $0.value.country }
        let correctAnswer = data.first(where: {
            !userChoices.keys.contains($0.key) &&           // Avoid duplicated cities
            !dataAsked.keys.contains($0.key) &&             // Avoid cities already asked
            !userChoicesCountry.contains($0.value.country)  // Avoid duplicated country names in userChoices
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

