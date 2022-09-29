//
//  CityMap.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 24/9/22.
//

import SwiftUI
import MapKit

struct CityMap: View {
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: MapInteractionModes())
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
    }
}

struct CityMap_Previews: PreviewProvider {
    static var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    static var previews: some View {
        CityMap(region: region)
            .frame(width: 300, height: 300)
    }
}
