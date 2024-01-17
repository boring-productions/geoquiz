//
//  Extensions.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/11/22.
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

extension ShapeStyle where Self == Color {
    static var atomicTangerine: Color {
        Color("AtomicTangerine")
    }
    
    static var blueBell: Color {
        Color("BlueBell")
    }
    
    static var chinaPink: Color {
        Color("ChinaPink")
    }
    
    static var maizeCrayola: Color {
        Color("MaizeCrayola")
    }
    
    static var mayaBlue: Color {
        Color("MayaBlue")
    }
    
    static var middleRed: Color {
        Color("MiddleRed")
    }
    
    static var pinkLavender: Color {
        Color("PinkLavender")
    }
    
    static var royalLightBlue: Color {
        Color("RoyalLightBlue")
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
