//
//  CityGame.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation
import AVFAudio
import SwiftUI
import MapKit

class CityGame: Game, ObservableObject {
    
    // Define type of generics
    typealias T = CityModel.CityData
    
    var data: [String: T]
    var dataAsked = [String: T]()
    
    @Published var mapImage: UIImage? = nil
    @Published var correctAnswer = (key: String(), value: T(country: String(), lat: Double(), lon: Double())) {
        willSet {
            getMapImage(lat: newValue.value.lat, lon: newValue.value.lon)
        }
    }
    
    // User
    @Published var userChoices = [String: T]()
    @Published var userScore = 0
    @Published var userLives = 3
    @Published var correctAnswers = [String: T]()
    @Published var wrongAnswers = [String: T]()
    
    // Alerts
    @Published var alertTitle = String()
    @Published var alertMessage = String()
    @Published var showingGameOverAlert = false
    @Published var showingEndGameAlert = false
    @Published var showingWrongAnswerAlert = false
    @Published var showingExitGameAlert = false
    
    // Animations
    @Published var scoreScaleAmount = 1.0
    @Published var livesScaleAmount = 1.0
    
    // Sound effects
    @Published var player: AVAudioPlayer?
    
    init() {
        let data: CityModel = load("cities.json")
        self.data = data.cities
        askQuestion()
    }
}

extension CityGame {
    func getMapImage(lat: Double, lon: Double) {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: lat,
                longitude: lon
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 1.0,
                longitudeDelta: 1.0
            )
        )

        // Map options
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.region = region
        mapOptions.size = CGSize(width: 600, height: 600)
        mapOptions.showsBuildings = true

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

