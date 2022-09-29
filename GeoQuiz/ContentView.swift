//
//  ContentView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameName: GameName? = nil
    @State private var showingBuyLivesModalView = false
    @State private var showingSettingsModalView = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    NavigationLink(
                        destination: GuessTheFlagView(gameName: $gameName),
                        tag: GameName.guessTheFlag,
                        selection: $gameName
                    ) {
                        GameButton(
                            gradient: .main,
                            level: "Level 1", symbol: "flag.fill", name: "Guess the flag"
                        )
                    }
                    
                    NavigationLink(
                        destination: GuessTheCapitalView(gameName: $gameName),
                        tag: GameName.guessTheCapital,
                        selection: $gameName
                    ) {
                        GameButton(
                            gradient: .secondary,
                            level: "Level 2", symbol: "building.2.fill", name: "Guess the capital"
                        )
                    }

                    NavigationLink(
                        destination: GuessTheCountryView(gameName: $gameName),
                        tag: GameName.guessTheCountry,
                        selection: $gameName
                    ) {
                        GameButton(
                            gradient: .tertiary,
                            level: "Level 3", symbol: "globe.americas.fill", name: "Guess the country"
                        )
                    }
//
//                    NavigationLink(
//                        destination: Text("Guess the population"),
//                        tag: GameName.guessThePopulation,
//                        selection: $gameName
//                    ) {
//                        GameButton(
//                            gradient: .quaternary,
//                            level: "Level 4", symbol: "person.3.fill", name: "Guess the population"
//                        )
//                    }
                }
                .padding()
            }
            .navigationTitle("Select a game 🎮")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettingsModalView = true
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                ToolbarItemGroup {
                    Button {
                        showingBuyLivesModalView = true
                    } label: {
                        Label("Buy lives", systemImage: "heart.fill")
                    }
                }
            }
            .sheet(isPresented: $showingBuyLivesModalView) {
                BuyLivesModalView()
            }
            
            .sheet(isPresented: $showingSettingsModalView) {
                SettingsModalView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
