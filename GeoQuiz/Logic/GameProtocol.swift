//
//  GameProtocol.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation

protocol Game {
    var userScore: Int { get }
    var userLives: Int { get }
    var questionCounter: Int { get }
    var alertTitle: String { get }
    var alertMessage: String { get }
    var showingBuyLivesView: Bool { get set }
    var showingNoLivesAlert: Bool { get set }
    var showingWrongAnswerAlert: Bool { get set }
    var showingEndGameAlert: Bool { get set }
    
    func askQuestion()
    func answered(userChoice: String)
    
}
