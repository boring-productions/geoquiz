//
//  SettingsRow.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/10/22.
//

import SwiftUI

struct SettingsRow: View {
    var color: Color
    var symbol: String
    var text: String
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 30, height: 30)
                .foregroundColor(color)
                .overlay(
                    Image(systemName: symbol)
                        .foregroundColor(.white)
                )
            
            Text(text)
                .foregroundColor(.primary)
        }
        
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(
            color: .mayaBlue,
            symbol: "info",
            text: "About"
        )
    }
}
