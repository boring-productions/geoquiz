//
//  SettingsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct SettingsModalView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var user = User()

    var lives: [Int] {
        var lives = [Int]()
        for i in stride(from: 5, to: 55, by: 5) {
            lives.append(i)
        }
        
        return lives
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("❤️ Lives", selection: $user.settings.numberOfLives) {
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
                    Toggle("Haptics", isOn: $user.settings.haptics)
                    Toggle("Sound effects", isOn: $user.settings.sound)
                } header: {
                    Text("Effects")
                }
                
                Section {
                    LinkComponent(
                        color: .mayaBlue,
                        iconName: "info.circle.fill",
                        text: "About",
                        url: URL(string: "https://dennistech.io")!
                    )
                    
                    LinkComponent(
                        color: .atomicTangerine,
                        iconName: "ant.circle.fill",
                        text: "Report bugs",
                        url: URL(string: "mailto:dmartin@dennistech.io")!
                    )
                    
                    LinkComponent(
                        color: .blueBell,
                        iconName: "message.circle.fill",
                        text: "Twitter",
                        url: URL(string: "https://twitter.com/dennistech_")!
                    )
                } header: {
                    Text("Get in touch")
                }
            }
            .navigationTitle("Settings")
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
        SettingsModalView()
    }
}
