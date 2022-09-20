//
//  FlagImage.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/9/22.
//

import SwiftUI

struct FlagImage: View {
    @Environment(\.colorScheme) var colorScheme
    
    var flagSymbol: String
    var cornerRadius: Double
    
    var body: some View {
        Image(flagSymbol)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagSymbol: "es", cornerRadius: 20)
            .frame(height: 130)
    }
}
