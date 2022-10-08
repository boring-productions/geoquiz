//
//  UserClass.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/10/22.
//

import Foundation

class User: ObservableObject {
    @Published var settings = UserSettings() {
        didSet {
            if let userSettingsEncoded = try? JSONEncoder().encode(settings) {
                UserDefaults.standard.set(userSettingsEncoded, forKey: "UserSettings")
            }
        }
    }
    
    
    init() {
        if let userSettings = UserDefaults.standard.data(forKey: "UserSettings") {
            if let decodedUserSettings = try? JSONDecoder().decode(UserSettings.self, from: userSettings) {
                settings = decodedUserSettings
            }
        }
    }
}
