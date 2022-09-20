//
//  Haptics.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/9/22.
//

import Foundation
import SwiftUI

func hapticSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func hapticError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}
