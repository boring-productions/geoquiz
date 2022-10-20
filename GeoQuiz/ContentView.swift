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
                            gradient: GuessTheFlagInfo.gradient,
                            level: GuessTheFlagInfo.level,
                            symbol: GuessTheFlagInfo.symbol,
                            name: GuessTheFlagInfo.name
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
                            gradient: GuessTheCapitalInfo.gradient,
                            level: GuessTheCapitalInfo.level,
                            symbol: storeKitRC.isActive ? GuessTheCapitalInfo.symbol: "lock.fill",
                            name: GuessTheCapitalInfo.name
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
                            gradient: GuessTheCountryInfo.gradient,
                            level: GuessTheCountryInfo.level,
                            symbol: storeKitRC.isActive ? GuessTheCountryInfo.symbol: "lock.fill",
                            name: GuessTheCountryInfo.name
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
                            gradient: GuessThePopulationInfo.gradient,
                            level: GuessThePopulationInfo.level,
                            symbol: storeKitRC.isActive ? GuessThePopulationInfo.symbol: "lock.fill",
                            name: GuessThePopulationInfo.name
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
