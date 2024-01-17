//
//  DatasetView-ViewModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 10/11/22.
//

import Foundation

extension DatasetView {
    class ViewModel {
        let countries: Set<String>
        let cities: Set<String>
        
        init() {
            let countryData: CountryModel = Bundle.main.decode("countries.json")
            let cityData: CityModel = Bundle.main.decode("cities.json")
            
            self.countries = Set(countryData.countries.keys)
            self.cities = Set(cityData.cities.keys)
        }
    }
}
