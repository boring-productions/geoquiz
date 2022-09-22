//
//  GuessTheFlag.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import Foundation
import SwiftUI

class GuessTheFlag: Game, ObservableObject {    

    // Define type of generics
    var data: [String: String]
    var dataAsked = [String]()
    
    // Data
    @Published var correctAnswer = (key: String(), value: String())
    
    // User
    @Published var userChoices = [String: String]()
    @Published var userScore = 0
    @Published var userLives = 3
    
    // Alerts
    @Published var alertTitle = String()
    @Published var alertMessage = String()
    @Published var showingNoLivesAlert = false
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Modal views
    @Published var showingBuyLivesView = false
    
    init() {
        let flags: CountryFlags = load("CountryFlags.json")
        data = flags.countries
        askQuestion()
    }
}
