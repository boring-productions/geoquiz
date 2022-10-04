//
//  SettingsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct SettingsModalView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Difficulty
                } header: {
                    Text("Game")
                } footer: {
                    Text("The harder the difficulty the less lives you get.")
                }
                
                Section {
                    // Toggle to disable haptics
                    // Toggle to disable sound effects
                } header: {
                    Text("Effects")
                }
                
                Section {
                    // About
                    // Report bugs
                    // Twitter
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
