//
//  CountryModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 29/9/22.
//

import Foundation

struct CountryModel: Codable {
    let countries: [String: Country]
    
    struct Country: Codable, Equatable, Hashable {
        let flag: String
        let currency: String
        let population: Int
        let capital: String
        
        static func ==(lhs: Country, rhs: Country) -> Bool {
            lhs.flag == rhs.flag &&
            lhs.currency == rhs.currency &&
            lhs.population == rhs.population &&
            lhs.capital == rhs.capital
        }
    }
}
