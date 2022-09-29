//
//  CityModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation

struct CityModel: Codable {
    let cities: [String: CityData]
    
    struct CityData: Codable, Equatable {
        let country: String
        let lat: Double
        let lon: Double
        
        static func ==(lhs: CityData, rhs: CityData) -> Bool {
            lhs.country == rhs.country
        }
    }
}
