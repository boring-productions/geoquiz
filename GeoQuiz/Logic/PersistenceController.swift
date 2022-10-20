//
//  PersistenceController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import CoreData
import Foundation

class PersistenceController: ObservableObject {
    
    // Create mock data for previews
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
//        for _ in 0..<10 {
//            let playedGame = PlayedGame(context: viewContext)
//            playedGame.id = UUID()
//            playedGame.type = GameType(rawValue: Int16.random(in: 0...3))!
//            playedGame.score = Int32.random(in: 0...50)
//            playedGame.date = Date()
//            
//            if playedGame.type == .guessTheFlag || playedGame.type == .guessTheCapital {
//                playedGame.correctAnswers = ["Bangladesh", "Belgium", "Burkina Faso", "Bermuda", "Jamaica"]
//                playedGame.wrongAnswers = ["Belarus", "Russia"]
//            } else {
//                playedGame.correctAnswers = ["Herat", "Lobito", "Darregueira", "San Juan"]
//                playedGame.wrongAnswers = ["San Luis", "Oranjestad"]
//            }
//        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
        
    }()
    
    // Initialize container
    let container = NSPersistentContainer(name: "GeoQuiz")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
