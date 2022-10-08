//
//  CityMapHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 4/10/22.
//

import SwiftUI
import MapKit

struct CityMap: View {
    @ObservedObject var game: CityGame
    @State private var mapImage: UIImage? = nil
    
    var body: some View {
        VStack {
            if let mapImage = mapImage {
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
        .onChange(of: game.correctAnswer.value) { _ in getMapImage() }
        .onAppear(perform: getMapImage)
    }
    
    private func getMapImage() {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: game.correctAnswer.value.lat,
                longitude: game.correctAnswer.value.lon
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        )

        // Map options
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.region = region
        mapOptions.size = CGSize(width: 500, height: 500)
        mapOptions.pointOfInterestFilter = .excludingAll

        // Create the snapshotter and run it
        let snapshotter = MKMapSnapshotter(options: mapOptions)
        snapshotter.start { (snapshot, error) in
            if let snapshot = snapshot {
                self.mapImage = snapshot.image
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct CityMap_Previews: PreviewProvider {
    static var previews: some View {
        CityMap(game: CityGame())
    }
}
