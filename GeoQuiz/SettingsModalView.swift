//
//  SettingsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct SettingsModalView: View {
    @ObservedObject var user: UserController
    
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
                    Picker("❤️ Lives", selection: $user.data.numberOfLives) {
                        ForEach(lives, id: \.self) { numberOfLives in
                            Text("\(numberOfLives)")
                                .tag(numberOfLives)
                        }
                    }
                } header: {
                    Text("Game")
                } footer: {
                    Text("Number of lives at the beginning of each game.")
                }
                
                Section {
                    Toggle("Haptics", isOn: $user.data.haptics)
                    Toggle("Sound effects", isOn: $user.data.sound)
                } header: {
                    Text("Effects")
                }
                
                Section {
                    LinkComponent(
                        color: .mayaBlue,
                        symbol: "info.circle.fill",
                        text: "About",
                        url: URL(string: "https://dennistech.io")!
                    )
                    
                    LinkComponent(
                        color: .atomicTangerine,
                        symbol: "ant.circle.fill",
                        text: "Report bugs",
                        url: URL(string: "mailto:dmartin@dennistech.io")!
                    )
                    
                    LinkComponent(
                        color: .blueBell,
                        symbol: "message.circle.fill",
                        text: "Twitter",
                        url: URL(string: "https://twitter.com/dennistech_")!
                    )
                } header: {
                    Text("Get in touch")
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
        SettingsModalView(user: UserController())
    }
}
