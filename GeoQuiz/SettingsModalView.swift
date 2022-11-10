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

    var lives: [Int] {
        var lives = [Int]()
        for i in stride(from: 5, to: 55, by: 5) {
            lives.append(i)
        }
        
        return lives
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("❤️ Lives", selection: $userController.data.numberOfLives) {
                        ForEach(lives, id: \.self) { numberOfLives in
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
                    Picker("Flag shape", selection: $userController.data.guessTheFlagShape) {
                        ForEach(GuessTheFlagShape.allCases, id: \.self) { shape in
                            Text(shape.localizedName)
                                .tag(shape)
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
                    
                    NavigationLink(destination: DatasetView()) {
                        SettingsRow(
                            color: .atomicTangerine,
                            symbol: "square.stack.3d.up.fill",
                            text: "Dataset"
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
                            
                            if let versionNumber = getVersion() {
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
