//
//  ProfileModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 25/9/22.
//

import SwiftUI
import PhotosUI

struct ProfileModalView: View {
    @ObservedObject var user: User
    @ObservedObject var storeKitRC: StoreKitRC
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse),
    ]) var playedGames: FetchedResults<PlayedGame>
    
    @State private var showingEditModalView = false
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        UserProfile(user: user, storeKitRC: storeKitRC)
                        
                        UserProgress(playedGames: playedGames)
                        
                        ForEach(playedGames) { playedGame in
                            RecentGame(game: playedGame)
                        }
                        .onDelete(perform: deleteGame)
                    }
                    .padding()
                }
                .background(.customBackground)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Label("Exit", systemImage: "multiply")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            showingEditModalView = true
                        }
                    }
                }
                
                .sheet(isPresented: $showingEditModalView) {
                    ProfileEditModalView(user: user)
                }
            }
        
    }
    
    private func deleteGame(at offsets: IndexSet) {
        for offset in offsets {
            let game = playedGames[offset]
            moc.delete(game)
        }
        
        try? moc.save()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(user: User(), storeKitRC: StoreKitRC())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
