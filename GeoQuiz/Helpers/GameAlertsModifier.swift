//
//  GameAlertsModifier.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct GameAlertsModifier<T: Game>: ViewModifier {
    @ObservedObject var game: T
    @Binding var gameName: GameName?
    
    func body(content: Content) -> some View {
        content
            .alert(game.alertTitle, isPresented: $game.showingWrongAnswerAlert) {
                Button("Continue", role: .cancel) { game.askQuestion() }
            } message: {
                Text(game.alertMessage)
            }
        
            .alert(game.alertTitle, isPresented: $game.showingNoLivesAlert) {
                Button("Buy lives") { game.showingBuyLivesView = true }
                Button("Exit", role: .destructive) { gameName = nil }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(game.alertMessage)
            }
            
            .alert(game.alertTitle, isPresented: $game.showingEndGameAlert) {
                Button("Exit", role: .cancel) { gameName = nil }
            } message: {
                Text(game.alertMessage)
            }
    }
}
