//
//  CustomGradients.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 13/9/22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Gradient {
    static var main: Gradient {
        Gradient(colors: [Color("MayaBlue"), Color("RoyalLightBlue")])
    }
    
    static var secondary: Gradient {
        Gradient(colors: [Color("AtomicTangerine"), Color("ChinaPink")])
    }
    
    static var tertiary: Gradient {
        Gradient(colors: [Color("PinkLavender"), Color("BlueBell")])
    }
    
    static var quaternary: Gradient {
        Gradient(colors: [Color("MaizeCrayola"), Color("MiddleRed")])
    }
}
