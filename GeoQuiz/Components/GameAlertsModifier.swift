//
//  GameAlertsModifier.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct GameAlertsModifier<T: Game>: ViewModifier {
    @ObservedObject var game: T
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .alert(game.alertTitle, isPresented: $game.showingWrongAnswerAlert) {
                Button("Continue", role: .cancel) {
                    game.askQuestion {
                        game.selector()
                    }
                }
            } message: {
                Text(game.alertMessage)
            }
        
            .alert(game.alertTitle, isPresented: $game.showingGameOverAlert) {
                Button("Try again") {
                    game.reset {
                        game.selector()
                    }
                }
                Button("Exit", role: .cancel) { dismiss()}
            } message: {
                Text(game.alertMessage)
            }
            
            .alert(game.alertTitle, isPresented: $game.showingEndGameAlert) {
                Button("Play again") {
                    game.reset() {
                        game.selector()
                    }
                }
                Button("Exit", role: .cancel) { dismiss() }
            } message: {
                Text(game.alertMessage)
            }
        
            .alert("Are you sure?", isPresented: $game.showingExitGameAlert) {
                Button("Exit", role: .destructive) { dismiss() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Progress won't be saved.")
            }
    }
}
