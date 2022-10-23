//
//  CityMap.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 4/10/22.
//

import SwiftUI
import MapKit

struct CityMap: View {
    @ObservedObject var game: CityGameController
    
    @StateObject var mapController: MapController
    
    init(game: CityGameController) {
        self.game = game
        self._mapController = StateObject(wrappedValue: MapController())
    }
    
    var body: some View {
        VStack {
            if let mapImage = mapController.image {
                Image(uiImage: mapImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .strokeBorder(.white, lineWidth: 4)
                    }
                    .shadow(radius: 10)
            } else {
                ProgressView()
            }
        }
        .onChange(of: game.correctAnswer.value) { _ in
            mapController.getMapImage(lat: game.correctAnswer.value.lat, lon: game.correctAnswer.value.lon)
        }
        
        .onAppear {
            mapController.getMapImage(lat: game.correctAnswer.value.lat, lon: game.correctAnswer.value.lon)
        }
    }
}

struct CityMap_Previews: PreviewProvider {
    static var previews: some View {
        CityMap(game: CityGameController())
    }
}
