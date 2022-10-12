//
//  ActivityAlertHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 12/10/22.
//

import SwiftUI

struct ActivityAlert: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
            Text("Loading")
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

struct ActivityAlert_Previews: PreviewProvider {
    static var previews: some View {
        ActivityAlert()
    }
}
