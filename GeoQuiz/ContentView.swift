//
//  ContentView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var path: [GameType] = []
    
    @State private var showingBuyPremiumModalView = false
    @State private var showingSettingsModalView = false
    @State private var showingProfileModalView = false
    
    @StateObject var storeKitRC = StoreKitRC()
    @StateObject var user = User()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(showsIndicators: false) {
                
                NavigationLink(value: GameType.guessTheFlag) { EmptyView() }
                NavigationLink(value: GameType.guessTheCapital) { EmptyView() }
                NavigationLink(value: GameType.guessTheCountry) { EmptyView() }
                NavigationLink(value: GameType.guessThePopulation) { EmptyView() }
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Select a game 🎮")
                        .font(.largeTitle.bold())
                        .padding(.bottom)
                    
                    Button {
                        path.append(.guessTheFlag)
                    } label: {
                        GameButton(
                            gradient: .main,
                            level: "Level 1",
                            symbol: "flag.fill",
                            name: "Guess the flag"
                        )
                    }
                    
                    Button {
                        if storeKitRC.isActive {
                            path.append(.guessTheCapital)
                        } else {
                            showingBuyPremiumModalView = true
                        }
                    } label: {
                        GameButton(
                            gradient: .secondary,
                            level: "Level 2",
                            symbol: storeKitRC.isActive ? "building.2.fill": "lock.fill",
                            name: "Guess the capital"
                        )
                    }
                    
                    Button {
                        if storeKitRC.isActive {
                            path.append(.guessTheCountry)
                        } else {
                            showingBuyPremiumModalView = true
                        }
                    } label: {
                        GameButton(
                            gradient: .tertiary,
                            level: "Level 3",
                            symbol: storeKitRC.isActive ? "globe.americas.fill": "lock.fill",
                            name: "Guess the country"
                        )
                    }
                    
                    Button {
                        if storeKitRC.isActive {
                            path.append(.guessThePopulation)
                        } else {
                            showingBuyPremiumModalView = true
                        }
                    } label: {
                        GameButton(
                            gradient: .quaternary,
                            level: "Level 4",
                            symbol: storeKitRC.isActive ? "person.fill": "lock.fill",
                            name: "Guess the population"
                        )
                    }

                }
                .padding()
            }
            .navigationTitle("GeoQuiz")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationDestination(for: GameType.self) { gameMode in
                switch gameMode {
                case .guessTheFlag:
                    GuessTheFlagView()
                case .guessTheCapital:
                    GuessTheFlagView()
                case .guessTheCountry:
                    GuessTheCountryView()
                case .guessThePopulation:
                    GuessThePopulationView()
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettingsModalView = true
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                ToolbarItemGroup {
                    if !storeKitRC.isActive {
                        Button {
                            showingBuyPremiumModalView = true
                        } label: {
                            Label("Buy premium", systemImage: "star")
                        }
                    }
                    
                    Button {
                        showingProfileModalView = true
                    } label: {
                        Label("Profile", systemImage: "person")
                    }
                }
            }
            .sheet(isPresented: $showingBuyPremiumModalView) {
                BuyPremiumModalView(storeKitRC: storeKitRC)
            }
            
            .sheet(isPresented: $showingSettingsModalView) {
                SettingsModalView(user: user)
            }
            
            .sheet(isPresented: $showingProfileModalView) {
                ProfileModalView(user: user, storeKitRC: storeKitRC)
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
