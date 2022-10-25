//
//  PersistenceController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import CoreData
import SwiftUI

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        createMockData(nil, viewContext)

        return result
    }()

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
    
    #if DEBUG
    static func createMockData(_ playedGames: FetchedResults<PlayedGame>?, _ moc: NSManagedObjectContext) {
        for _ in 0..<10 {
            let playedGame = PlayedGame(context: moc)
            
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
            try moc.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    #endif
}
