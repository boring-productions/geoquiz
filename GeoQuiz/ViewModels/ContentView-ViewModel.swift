//
//  ContentView-ViewModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/11/22.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var path: [GameType] = []
        @Published var showingBuyPremiumModalView = false
        @Published var showingSettingsModalView = false
        @Published var showingProfileModalView = false
        
        let premiumGames: [GameType] = [.guessTheCapital, .guessTheCountry, .guessThePopulation]
        
        func go(to gameType: GameType) {
            path.append(gameType)
        }
    }
}
