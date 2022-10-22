//
//  FlagImageHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/9/22.
//

import SwiftUI

struct FlagImage: View {
    var flagSymbol: String
    var cornerRadius: Double
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(flagSymbol)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagSymbol: "es", cornerRadius: 20)
            .frame(height: 130)
    }
}
