//
//  FlagImage.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/9/22.
//

import SwiftUI

struct FlagImage: View {
    var flagSymbol: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(flagSymbol)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagSymbol: "es")
            .frame(height: 130)
    }
}
