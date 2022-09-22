//
//  GameStatsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct GameStatsModalView<T: Game>: View {
    @ObservedObject var game: T
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(Array(game.correctAnswers.keys), id: \.self) { key in
                        Text(key)
                    }
                } header: {
                    Text("Correct answers")
                }
                
                Section {
                    ForEach(Array(game.wrongAnswers.keys), id: \.self) { key in
                        Text(key)
                    }
                } header: {
                    Text("Wrong answers")
                }
            }
            .navigationTitle("Game stats")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Exit", systemImage: "multiply")
                    }
                }
            }
        }
    }
}

struct GameStatsModalView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsModalView(game: GuessTheFlag())
    }
}
