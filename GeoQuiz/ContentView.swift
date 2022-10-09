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
    @State private var showingProfileModalView = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Select a game 🎮")
                        .font(.largeTitle.bold())
                        .padding(.bottom)
                    
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
                    
                    NavigationLink(destination: GuessThePopulationView()) {
                        GameButton(
                            gradient: .quaternary,
                            level: "Level 4", symbol: "person.fill", name: "Guess the population"
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("GeoQuiz")
            .navigationBarTitleDisplayMode(.inline)
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
                    
                    Button {
                        showingProfileModalView = true
                    } label: {
                        Label("Profile", systemImage: "person")
                    }
                }
            }
            .sheet(isPresented: $showingBuyPremiumModalView) {
                BuyPremiumModalView()
            }
            
            .sheet(isPresented: $showingSettingsModalView) {
                SettingsModalView()
            }
            
            .sheet(isPresented: $showingProfileModalView) {
                ProfileModalView()
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
