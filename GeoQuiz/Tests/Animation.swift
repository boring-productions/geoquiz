//
//  Animation.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 21/9/22.
//

import SwiftUI

struct Animation: View {
    @State private var amount = 1.0
    
    var body: some View {
        Button {
            withAnimation(.easeIn(duration: 0.5)) {
                amount += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeIn(duration: 0.5)) {
                    amount = 1
                }
            }
        } label: {
            Circle()
                .overlay(
                    Text("Button")
                        .foregroundColor(.white)
                )
        }
        .frame(height: 100)
        .scaleEffect(amount)
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        Animation()
    }
}
