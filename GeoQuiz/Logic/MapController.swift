//
//  MapController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/10/22.
//

import Foundation
import MapKit

class MapController: ObservableObject {
    @Published var image: UIImage? = nil
    
    func getMapImage(lat: Double, lon: Double) {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
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
                self.image = snapshot.image
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
