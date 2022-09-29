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
    @Published var correctAnswer = (key: String(), value: T(country: String(), lat: Double(), lon: Double()))
    
    // User
    @Published var userChoices = [String: T]()
    @Published var userScore = 0
    @Published var userLives = 3
    @Published var correctAnswers = [String: T]()
    @Published var wrongAnswers = [String: T]()
    
    // Alerts
    @Published var alertTitle = String()
    @Published var alertMessage = String()
    @Published var showingNoLivesAlert = false
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingExitGameAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Modal views
    @Published var showingBuyLivesView = false
    @Published var showingGameStatsView = false
    
    // Sound effects
    @Published var player: AVAudioPlayer?
    
    init() {
        let data: CityModel = load("cities.json")
        self.data = data.cities
        askQuestion()
    }
}
