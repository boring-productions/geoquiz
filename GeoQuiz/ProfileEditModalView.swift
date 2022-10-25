//
//  ProfileEditModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//

import SwiftUI
import PhotosUI

struct ProfileEditModalView: View {
    @ObservedObject var userController: UserController
    
    @State var newUsername: String
    @State private var selectedImageItem: PhotosPickerItem? = nil
    
    @Environment(\.dismiss) var dismiss
    
    init(userController: UserController) {
        self.userController = userController
        self._newUsername = State(initialValue: userController.data.username)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        PhotosPicker(
                            selection: $selectedImageItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                UserImage(userController: userController)
                                    .frame(height: 150)
                                    .overlay(
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.white)
                                            .font(.title)
                                            .shadow(radius: 5)
                                    )
                            }
                            .onChange(of: selectedImageItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        userController.data.imageData = data
                                    }
                                }
                            }
                        
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
                
                Section {
                    TextField("Enter a username", text: $newUsername)
                } header: {
                    Text("Username")
                }
                
            }
            .navigationTitle("Edit profile")
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
                    Button {
                        userController.data.username = newUsername
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .disabled(newUsername.isEmpty)
                }
            }
        }
    }
}

struct ProfileEditModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditModalView(userController: UserController())
    }
}
