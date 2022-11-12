//
//  GameProtocol+Extension.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation
import SwiftUI
import AVFAudio
import CoreData

@objc
public enum GameType: Int16, CaseIterable {
    case guessTheFlag
    case guessTheCapital
    case guessTheCountry
    case guessThePopulation
}

@MainActor protocol Game: ObservableObject {
    
    // Define generic type
    associatedtype T: Equatable
    
    // Game
    var data: [String: T] { get set}
    var dataAsked: [String: T] { get set }
    
    var userChoices: [String: T] { get set }
    var userScore: Int { get set }
    var userLives: Int { get set }
    
    var correctAnswer: (key: String, value: T) { get set }
    var correctAnswers: [String: T] { get set }
    var wrongAnswers: [String: T] { get set }
    
    // Alerts
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    
    var showingEndGameAlert: Bool { get set }
    var showingWrongAnswerAlert: Bool { get set }
    var showingExitGameAlert: Bool { get set }
    
    // Animations
    var scoreScaleAmount: Double { get set }
    var livesScaleAmount: Double { get set }
    
    // Sound effects
    var player: AVAudioPlayer? { get set }
}

extension Game {
    var questionCounter: Int {
       dataAsked.count
    }
    
    // MARK: - Ask new question
    func ask() {
        guard questionCounter < data.count else {
            alertTitle = "⭐️ Congratulations ⭐️"
            alertMessage = "You completed the game."
            showingEndGameAlert = true
            
            return
        }
        
        var userChoices = [String: T]()
        
        while userChoices.count < 2 {
            let choice = data.randomElement()!
            userChoices[choice.key] = choice.value
        }
        
        let correctKey = data.keys.shuffled().first(where: {
            !userChoices.keys.contains($0) &&               // Avoid duplicated items
            !dataAsked.keys.contains($0)                    // Avoid items already asked
        })!
        
        let correctValue = data[correctKey]!
        
        userChoices[correctKey] = correctValue
        dataAsked[correctKey] = correctValue
        correctAnswer = (key: correctKey, value: correctValue)
        self.userChoices = userChoices
    }
    
    // MARK: - Answer question
    func answer(choice: (key: String, value: T), wrongMessage: String) {
        let haptics = HapticsController()
        
        if correctAnswer == choice {
            haptics.success()
            playSound("correctAnswer")
            
            withAnimation(.easeIn(duration: 0.5)) {
                scoreScaleAmount += 1
                userScore += 1
            }
            
            correctAnswers[correctAnswer.key] = correctAnswer.value
            ask()
        } else {
            haptics.error()
            playSound("wrongAnswer")

//            withAnimation(.easeIn(duration: 0.5)) {
//                livesScaleAmount += 1
//                userLives -= 1
//            }
            
            wrongAnswers[choice.key] = choice.value
            
            if userLives == 0 {
                alertTitle = "🤕 Game over 🤕"
                alertMessage = "Get up and try again."
                showingEndGameAlert = true
            } else {
                alertTitle = "🔴 Wrong 🔴"
                alertMessage = "\(wrongMessage). You have \(userLives) lives left."
                showingWrongAnswerAlert = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            withAnimation(.easeIn(duration: 0.5)) {
                scoreScaleAmount = 1
                livesScaleAmount = 1
            }
        }
    }
    
    // MARK: - Save game
    func save(_ gameType: GameType, with moc: NSManagedObjectContext) {
        let playedGame = PlayedGame(context: moc)

        playedGame.type = gameType
        playedGame.date = Date()
        playedGame.score = Int32(userScore)
        playedGame.correctAnswers = Array(correctAnswers.keys)
        playedGame.wrongAnswers = Array(wrongAnswers.keys)
        
        do {
            try moc.save()
        } catch {
            print("Couldn't save object to CoreData: \(error)")
        }
    }
    
    // MARK: - Play sound effect
    private func playSound(_ filename: String) {
        let user = UserController()
        
        if user.data.sound {
            guard let soundFileURL = Bundle.main.url(forResource: filename, withExtension: "wav") else {
                fatalError("Sound file \(filename) couldn't be found")
            }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.ambient)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                fatalError("Couldn't activate session")
            }
            
            do {
                player = try AVAudioPlayer(contentsOf: soundFileURL)
                player?.play()
            } catch {
                fatalError("Couldn't play sound effect")
            }
        }
    }
}
