//
//  ProgressBarHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import SwiftUI

struct ProgressBar: View {
    let pctScore: Double
    let gradient: Gradient
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .foregroundColor(.customBackground)
                    .frame(height: 6)
                
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .trailing, endPoint: .leading
                        )
                    )
                    .frame(width: geo.size.width * pctScore, height: 6)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(pctScore: 0.3, gradient: .main)
    }
}
