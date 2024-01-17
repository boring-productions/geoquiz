//
//  CityGameController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation
import AVFAudio

@MainActor class CityGameController: Game, ObservableObject {
    
    // Define generic type
    typealias T = CityModel.City
    
    // Game
    var data: [String: T]
    var dataAsked = [String: T]()
    
    @Published var userChoices = [String: T]()
    @Published var userScore = 0
    @Published var userLives = 3
    
    @Published var correctAnswer = (key: "", value: T(country: "", lat: Double(), lon: Double()))
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
        let shuffledCities = data.cities.shuffled()
        var cities = [String: T]()
        
        for _ in 1...100 {
            let countryNames = cities.map { $0.value.country }
            let city = shuffledCities.first(where: {
                !countryNames.contains($0.value.country)
            })!
            
            cities[city.key] = city.value
        }
        
        self.data = cities
        
        let user = UserController()
        userLives = user.data.numberOfLives
        
        if let userData = UserDefaults.standard.data(forKey: "UserData") {
            if let decodedUserData = try? JSONDecoder().decode(UserDataModel.self, from: userData) {
                userLives = decodedUserData.numberOfLives
            }
        }
        
        ask()
    }
}


