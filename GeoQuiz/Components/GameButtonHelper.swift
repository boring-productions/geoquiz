//
//  GameButtonHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 5/9/22.
//

import SwiftUI

struct GameButton: View {
    let gradient: Gradient
    let level: String
    let symbol: String
    let name: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: gradient,
                    startPoint: .trailing, endPoint: .leading
                )
            )
            .frame(height: 180)
            .frame(maxWidth: 700)
            .overlay {
                ZStack(alignment: .trailing) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: symbol)
                                .font(.headline)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1.5)
                                )
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(level)
                                .font(.callout)
                            
                            Text(name)
                                .font(.title.bold())
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                }
            }
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(
            gradient: .main,
            level: "Level 1",
            symbol: "flag.fill",
            name: "Guess the flag"
        )
    }
}
