//
//  ProfileModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 25/9/22.
//

import SwiftUI

struct ProfileModalView: View {
    @ObservedObject var userController: UserController
    @ObservedObject var storeController: StoreController
    
    @State private var showingEditModalView = false
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse),
    ]) var playedGames: FetchedResults<PlayedGame>
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    UserProfile(
                        userController: userController,
                        storeController: storeController,
                        isShowing: $showingEditModalView
                    )
                    
                    if !playedGames.isEmpty {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Latest games")
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                NavigationLink {
                                    PlayedGamesList()
                                } label: {
                                    HStack {
                                        Text("Show all")
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .disabled(playedGames.isEmpty)
                            }
                            
                            ForEach(playedGames.prefix(8)) { playedGame in
                                RecentGame(game: playedGame)
                                    .padding()
                                    .background(Color(.secondarySystemGroupedBackground))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Exit", systemImage: "multiply")
                    }
                }
            }
            
            .sheet(isPresented: $showingEditModalView) {
                ProfileEditModalView(userController: userController)
            }
            
            #if DEBUG
            .onAppear {
                if playedGames.isEmpty {
                    PersistenceController.createMockData(with: moc)
                }
            }
            #endif
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(userController: UserController(), storeController: StoreController())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
