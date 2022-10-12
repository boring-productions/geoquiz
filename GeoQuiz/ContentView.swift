//
//  ContentView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameModeSelection: GameMode? = nil
    
    @State private var showingBuyPremiumModalView = false
    @State private var showingSettingsModalView = false
    @State private var showingProfileModalView = false
    
    @StateObject var storeKitRC = StoreKitRC()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: GuessTheFlagView(),
                    tag: GameMode.guessTheFlag,
                    selection: $gameModeSelection)
                {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: GuessTheCapitalView(),
                    tag: GameMode.guessTheCapital,
                    selection: $gameModeSelection)
                {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: GuessTheCountryView(),
                    tag: GameMode.guessTheCountry,
                    selection: $gameModeSelection)
                {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: GuessThePopulationView(),
                    tag: GameMode.guessThePopulation,
                    selection: $gameModeSelection)
                {
                    EmptyView()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Select a game 🎮")
                            .font(.largeTitle.bold())
                            .padding(.bottom)
                        
                        Button {
                            gameModeSelection = .guessTheFlag
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
                                gameModeSelection = .guessTheCapital
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
                                gameModeSelection = .guessTheCountry
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
                                gameModeSelection = .guessThePopulation
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
