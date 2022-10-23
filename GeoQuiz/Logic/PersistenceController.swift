//
//  PersistenceController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    // Create mock data for previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
            let playedGame = PlayedGame(context: viewContext)
            playedGame.type = GameType(rawValue: Int16.random(in: 0...3))!
            playedGame.score = Int32.random(in: 0...50)
            playedGame.date = Date()
            
            if playedGame.type == .guessTheFlag || playedGame.type == .guessTheCapital {
                playedGame.correctAnswers = ["Bangladesh", "Belgium", "Burkina Faso", "Bermuda", "Jamaica"]
                playedGame.wrongAnswers = ["Belarus", "Russia"]
            } else {
                playedGame.correctAnswers = ["Herat", "Lobito", "Darregueira", "San Juan"]
                playedGame.wrongAnswers = ["San Luis", "Oranjestad"]
            }
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
    
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "GeoQuiz")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
