//
//  GameProtocol.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation
import SwiftUI

protocol Game: ObservableObject {
    
    // Define generic type
    associatedtype T: Equatable
    
    // Game
    var data: [String: T] { get set}
    var dataAsked: [String] { get set }
    var correctAnswer: (key: String, value: T) { get set }
    
    // User
    var userChoices: [String: T] { get set }
    var userScore: Int { get set }
    var userLives: Int { get set }
    
    // Alerts
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    var showingNoLivesAlert: Bool { get set }
    var showingEndGameAlert: Bool { get set }
    var showingWrongAnswerAlert: Bool { get set }
    
    // Animations
    var scoreScaleAmount: Double { get set }
    var livesScaleAmount: Double { get set }
    
    // Modal views
    var showingBuyLivesView: Bool { get set }
}

extension Game {
    var questionCounter: Int {
       dataAsked.count
    }
    
    func askQuestion() {
        guard questionCounter < data.count else {
            alertTitle = "Amazing!"
            alertMessage = "You've completed the game."
            showingEndGameAlert = true
            
            return
        }
        
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
            !userChoices.keys.contains($0.key) && !dataAsked.contains($0.key)
        })
        
        // Unwrap optional
        if let correctAnswer = correctAnswer {
            userChoices[correctAnswer.key] = correctAnswer.value
            dataAsked.append(correctAnswer.key)
            self.correctAnswer = correctAnswer
        } else {
            fatalError("Couldn't unwrap optional value")
        }
        
        self.userChoices = userChoices
    }
    
    func answer(_ choice: (key: String, value: T)) {
        guard userLives > 0 else {
            alertTitle = "Not enough lives!"
            alertMessage = "Please buy more lives to keep playing"
            showingNoLivesAlert = true

            return
        }
        
        if correctAnswer == choice {
            hapticSuccess()
            userScore += 1

            withAnimation(.easeIn(duration: 0.5)) {
                scoreScaleAmount += 1
            }
            
            askQuestion()
        } else {
            hapticError()
            userLives -= 1

            withAnimation(.easeIn(duration: 0.5)) {
                livesScaleAmount += 1
            }

            alertTitle = "Wrong!"
            alertMessage = "You have \(userLives) lives left"
            showingWrongAnswerAlert = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            withAnimation(.easeIn(duration: 0.5)) {
                scoreScaleAmount = 1
                livesScaleAmount = 1
            }
        }
    }
}
