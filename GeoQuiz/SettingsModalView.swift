//
//  SettingsModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/9/22.
//

import SwiftUI

struct SettingsModalView: View {
    @Environment(\.dismiss) var dismiss
    
    // CHANGE THIS IN PRODUCTION
    @State private var testHapticsIsOn = true
    @State private var testGameEffectIsOn = true
    // CHANGE THIS IN PRODUCTION
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Haptics is on", isOn: $testHapticsIsOn)
                Toggle("Game effect is on", isOn: $testGameEffectIsOn)
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
