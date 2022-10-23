//
//  GeoQuizApp.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 4/9/22.
//

import SwiftUI
import RevenueCat

@main
struct GeoQuizApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        Purchases.configure(withAPIKey: "appl_BymTxroeoaWiXAraaFjcPlHlqbf")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
