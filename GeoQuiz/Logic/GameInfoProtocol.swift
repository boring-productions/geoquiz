//
//  GameInfoProtocol+Structs.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import Foundation
import SwiftUI

@objc
public enum GameType: Int16, CaseIterable {
    case guessTheFlag
    case guessTheCapital
    case guessTheCountry
    case guessThePopulation
}

protocol GameInfo {
    var type: GameType { get }
    var level: String { get }
    var name: String { get }
    var isPremium: Bool { get }
    var symbol: String { get }
    var gradient: Gradient { get }
    var numberOfQuestions: Int { get }
}
