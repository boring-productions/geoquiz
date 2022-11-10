//
//  CoreDataController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/10/22.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataController {
    static func deleteGame(at offsets: IndexSet, from games: FetchedResults<PlayedGame>, with moc: NSManagedObjectContext) {
        for offset in offsets {
            let game = games[offset]
            moc.delete(game)
        }
        
        try? moc.save()
    }
}
