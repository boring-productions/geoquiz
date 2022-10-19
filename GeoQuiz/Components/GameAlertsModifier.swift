//
//  GameAlertsModifier.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI
import CoreData

struct GameAlertsModifier<T: Game>: ViewModifier {
    @ObservedObject var game: T
    
    var gameType: GameType
    var moc: NSManagedObjectContext
    
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
            
            .alert(game.alertTitle, isPresented: $game.showingEndGameAlert) {
                Button("Exit", role: .cancel) {
                    game.save(gameType, with: moc)
                    dismiss()
                }
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
