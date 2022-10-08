//
//  AnswerButtonHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 14/9/22.
//

import SwiftUI

struct AnswerButton: View {
    let optionName: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.white)
            .overlay(
                Text(optionName)
                    .font(.title2.bold())
                    .foregroundColor(color)
            )
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                AnswerButton(optionName: "Madrid", color: .royalLightBlue)
                    .frame(height: 70)
            }
            .padding()
        }
    }
}
