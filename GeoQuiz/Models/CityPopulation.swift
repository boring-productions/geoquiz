//
//  CityPopulation.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/9/22.
//

import Foundation

struct CityPopulation: Codable {
    let cities: [String: City]
    
    struct City: Codable {
        let country: String
        let population: [Population]
    }
    
    struct Population: Codable {
        let year: Int
        let value: Int
    }
}
