//
//  PlayedGamesList.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 23/10/22.
//

import SwiftUI

struct PlayedGamesList: View {
    var playedGames: FetchedResults<PlayedGame>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        List {
            ForEach(playedGames, id: \.id) { game in
                RecentGame(game: game)
            }
            .onDelete { indexSet in
                CoreDataController.deleteGame(at: indexSet, from: playedGames, with: moc)
            }
        }
        .navigationTitle("Played games")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
        }
    }
}
