//
//  LatestGamesPlaceholder.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 23/10/22.
//

import SwiftUI

struct LatestGamesPlaceholder: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gamecontroller.fill")
            Text("No recently played games")
        }
        .foregroundColor(.secondary)
    }
}

struct LatestGamesPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        LatestGamesPlaceholder()
    }
}
