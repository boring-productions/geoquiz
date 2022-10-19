//
//  UserDataModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/10/22.
//

import Foundation
import SwiftUI

struct UserData: Codable {
    
    // Settings
    var haptics: Bool = true
    var sound: Bool = true
    var numberOfLives: Int = 25
    
    // Profile
    var username: String = "Anonymous"
    var imageData: Data?
    
    var uiImage: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}
