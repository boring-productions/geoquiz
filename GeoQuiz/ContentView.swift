//
//  ContentView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingBuyPremiumModalView = false
    @State private var showingSettingsModalView = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: GuessTheFlagView()) {
                        GameButton(
                            gradient: .main,
                            level: "Level 1", symbol: "flag.fill", name: "Guess the flag"
                        )
                    }
                    
                    NavigationLink(destination: GuessTheCapitalView()) {
                        GameButton(
                            gradient: .secondary,
                            level: "Level 2", symbol: "building.2.fill", name: "Guess the capital"
                        )
                    }

                    NavigationLink(destination: GuessTheCountryView()) {
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
                        showingBuyPremiumModalView = true
                    } label: {
                        Label("Buy premium", systemImage: "star")
                    }
                }
            }
            .sheet(isPresented: $showingBuyPremiumModalView) {
                Text("Buy premium")
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
