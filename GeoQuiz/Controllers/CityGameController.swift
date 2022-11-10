//
//  CityGameController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation
import AVFAudio

class CityGameController: Game, ObservableObject {
    
    // Define type of generics
    typealias T = CityModel.City
    
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
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingExitGameAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Sound effects
    @Published var player: AVAudioPlayer?
    
    init() {
        let data: CityModel = Bundle.main.decode("cities.json")
        let shuffledCities = data.cities.shuffled().prefix(100)
        
        var cities = [String: T]()
        for shuffledCity in shuffledCities {
            cities[shuffledCity.key] = shuffledCity.value
        }
        
        self.data = cities
        
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

extension CityGameController {
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
        
        // Get correct answer
        let randomCityKeys = data.keys.shuffled()
        let userChoicesCountry = userChoices.map { $0.value.country }
        
        let correctCityKey = randomCityKeys.first(where: {
            !userChoices.keys.contains($0) &&                  // Avoid duplicated cities
            !dataAsked.keys.contains($0) &&                    // Avoid cities already asked
            !userChoicesCountry.contains(data[$0]!.country)    // Avoid duplicated country names in userChoices
        })

        // Unwrap optional
        if let correctCityKey = correctCityKey {
            let correctCityValue = data[correctCityKey]!
            
            userChoices[correctCityKey] = correctCityValue
            dataAsked[correctCityKey] = correctCityValue
            
            let correctAnswer = (key: correctCityKey, value: correctCityValue)
            self.correctAnswer = correctAnswer
        } else {
            fatalError("Couldn't unwrap optional value")
        }
        
        self.userChoices = userChoices
    }
}

