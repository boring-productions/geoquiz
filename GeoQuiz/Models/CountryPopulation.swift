//
//  CountryPopulation.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/9/22.
//

import Foundation

struct CountryPopulation: Codable {
    let countries: [String: Country]
    
    struct Country: Codable {
        let population: [Population]
    }
    
    struct Population: Codable {
        let year: Int
        let value: Int
    }
}
