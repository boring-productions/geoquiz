//
//  SettingsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct SettingsModalView: View {
    @ObservedObject var userController: UserController
    
    @Environment(\.dismiss) var dismiss

    let viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("❤️ Lives", selection: $userController.data.numberOfLives) {
                        ForEach(viewModel.lives, id: \.self) { numberOfLives in
                            Text("\(numberOfLives)")
                                .tag(numberOfLives)
                        }
                    }
                } header: {
                    Text("General")
                } footer: {
                    Text("Number of lives at the beginning of each game.")
                }
                
                Section {
                    Toggle("Haptics", isOn: $userController.data.haptics)
                    Toggle("Sound effects", isOn: $userController.data.sound)
                }
                
                Section {
                    Picker("Flag aspect ratio", selection: $userController.data.guessTheFlagAspectRatio) {
                        ForEach(GuessTheFlagAspectRatio.allCases, id: \.self) { aspectRatio in
                            Text(aspectRatio.localizedName)
                                .tag(aspectRatio)
                        }
                    }
                } header: {
                    Text("Guess the flag game")
                }
                
                Section {
                    Link(destination: URL(string: "https://dennistech.io")!) {
                        SettingsRow(
                            color: .mayaBlue,
                            symbol: "person.fill",
                            text: "About"
                        )
                    }
                    
                    Link(destination: URL(string: "mailto:dmartin@dennistech.io")!) {
                        SettingsRow(
                            color: .chinaPink,
                            symbol: "ant.fill",
                            text: "Report bugs"
                        )
                    }
                    
                    Link(destination: URL(string: "https://twitter.com/dennistech_")!) {
                        SettingsRow(
                            color: .blueBell,
                            symbol: "message.fill",
                            text: "Twitter"
                        )
                    }
                } footer: {
                    HStack {
                        Spacer()
                        VStack {
                            Text("© 2022 Dennis Technologies Ltd.")
                            Text("Proud to be indie.")
                            
                            if let versionNumber = viewModel.getVersion() {
                                Text("Version \(versionNumber)")
                            }
                        }
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Exit", systemImage: "multiply")
                    }
                }
            }
        }
    }
}

struct SettingsModalView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModalView(userController: UserController())
    }
}
