//
//  GameAlertsModifier.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI
import CoreData

struct GameAlertsModifier<T: Game>: ViewModifier {
    @ObservedObject var gameController: T
    
    var gameType: GameType
    var moc: NSManagedObjectContext
    
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .alert(gameController.alertTitle, isPresented: $gameController.showingWrongAnswerAlert) {
                Button("Continue", role: .cancel) {
                    gameController.askQuestion {
                        gameController.selector()
                    }
                }
            } message: {
                Text(gameController.alertMessage)
            }
            
            .alert(gameController.alertTitle, isPresented: $gameController.showingEndGameAlert) {
                Button("Exit", role: .cancel) {
                    gameController.save(gameType, with: moc)
                    dismiss()
                }
            } message: {
                Text(gameController.alertMessage)
            }
        
            .alert("Are you sure?", isPresented: $gameController.showingExitGameAlert) {
                Button("Exit", role: .destructive) { dismiss() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Progress won't be saved.")
            }
    }
}
