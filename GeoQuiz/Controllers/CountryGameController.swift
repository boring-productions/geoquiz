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
        let shuffledCountries = data.countries.shuffled().prefix(5)
        var countries = [String: T]()
        
        for shuffledCountry in shuffledCountries {
            countries[shuffledCountry.key] = shuffledCountry.value
        }
        
        self.data = countries
        
        print(countries)
        
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
