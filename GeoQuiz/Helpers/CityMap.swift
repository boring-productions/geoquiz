//
//  CityMap.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 4/10/22.
//

import SwiftUI

struct CityMap: View {
    @ObservedObject var game: CityGame
    
    var body: some View {
        Group {
            if let mapImage = game.mapImage {
                Image(uiImage: mapImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
            } else {
                ProgressView()
            }
        }
    }
}

struct CityMap_Previews: PreviewProvider {
    static var previews: some View {
        CityMap(game: CityGame())
    }
}
