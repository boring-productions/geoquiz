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
        SortDescriptor(\.date),
    ]) var playedGames: FetchedResults<PlayedGame>
    
    @State private var showingEditModalView = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack(spacing: 20) {
                        UserImage(uiImage: user.data.uiImage)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.data.username)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            if storeKitRC.isActive {
                                Text("Premium user ⭐️")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Game 1")
                        Capsule()
                            .frame(height: 6)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Game 1")
                        Capsule()
                            .frame(height: 6)
                    }
                    VStack(alignment: .leading) {
                        Text("Game 1")
                        Capsule()
                            .frame(height: 6)
                    }
                    VStack(alignment: .leading) {
                        Text("Game 1")
                        Capsule()
                            .frame(height: 6)
                    }
                } header: {
                    Text("Progress")
                }
                
                Section {
                    ForEach(playedGames) { playedGame in
                        HStack {
                            Text("\(playedGame.id)")
                            Text("\(playedGame.date)")
                        }
                    }
                } header: {
                    Text("Recent games")
                }
            }
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(user: User(), storeKitRC: StoreKitRC())
    }
}
