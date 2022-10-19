//
//  ProfileEditModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import SwiftUI
import PhotosUI

struct ProfileEditModalView: View {
    @ObservedObject var user: User
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                            UserImage(uiImage: user.data.uiImage)
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            user.data.imageData = data
                                        }
                                    }
                                }
                            
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    EmptyView()
                                }
                        }
                        
                        Spacer()
                    }
                } header: {
                    Text("Profile image")
                }
                
                Section {
                    TextField("Enter a username", text: $user.data.username)
                } header: {
                    Text("Username")
                }
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProfileEditModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditModalView(user: User())
    }
}
