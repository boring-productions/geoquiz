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
    
    @StateObject var storeKitController = StoreKitController()
    @StateObject var userController = UserController()
    
    let premiumGames: [GameType] = [.guessTheCapital, .guessTheCountry, .guessThePopulation]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(showsIndicators: false) {
                ForEach(GameType.allCases, id: \.rawValue) { gameType in
                    NavigationLink(value: gameType) { EmptyView() }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Select a game 🎮")
                        .font(.largeTitle.bold())
                        .padding(.bottom)
                    
                    Button {
                        path.append(.guessTheFlag)
                    } label: {
                        GameButton(gameType: .guessTheFlag, isActive: true)
                    }
                    
                    ForEach(premiumGames, id: \.rawValue) { gameType in
                        Button {
                            if storeKitController.premiumIsActive {
                                path.append(gameType)
                            } else {
                                showingBuyPremiumModalView = true
                            }
                            } label: {
                                GameButton(gameType: gameType, isActive: storeKitController.premiumIsActive)
                            }
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
                        GuessTheCapitalView()
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
                        if !storeKitController.premiumIsActive {
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
                    BuyPremiumModalView(storeKitController: storeKitController)
                }
                
                .sheet(isPresented: $showingSettingsModalView) {
                    SettingsModalView(user: userController)
                }
                
                .sheet(isPresented: $showingProfileModalView) {
                    ProfileModalView(userController: userController, storeKitController: storeKitController)
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
