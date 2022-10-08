//
//  HapticsClass.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation
import SwiftUI

class Haptics {
    private var user = User()
    
    func success() {
        if user.settings.haptics {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }

    func error() {
        if user.settings.haptics {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
}
