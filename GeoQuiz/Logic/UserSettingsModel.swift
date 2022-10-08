//
//  UserSettingsModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/10/22.
//

import Foundation

struct UserSettings: Codable {
    var haptics: Bool = true
    var sound: Bool = true
    var numberOfLives: Int = 25
}
