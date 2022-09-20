//
//  ContentView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameName: GameName? = nil
    @State private var showingBuyLivesModal = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    NavigationLink(tag: GameName.guessTheFlag, selection: $gameName) {
                        GuessTheFlagView(gameName: $gameName)
                    } label: {
                        GameButton(
                            gradient: .main,
                            level: "Level 1", symbol: "globe.americas.fill", name: "Guess the flag"
                        )
                    }
                    
                    NavigationLink(tag: GameName.guessTheCapital, selection: $gameName) {
                        GuessTheCapitalView(gameName: $gameName)
                    } label: {
                        GameButton(
                            gradient: .secondary,
                            level: "Level 2", symbol: "globe.americas.fill", name: "Guess the capital"
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Select a game 🎮")
            .toolbar {
                Button {
                    showingBuyLivesModal = true
                } label: {
                    Label("Buy lives", systemImage: "heart.fill")
                }
            }
            .sheet(isPresented: $showingBuyLivesModal) {
                BuyLivesModal()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
