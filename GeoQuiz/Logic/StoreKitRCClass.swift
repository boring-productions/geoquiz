//
//  StoreKitRCClass.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/10/22.
//

import Foundation
import RevenueCat

class StoreKitRC: ObservableObject {
    @Published var productPrice: String?
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""

    init() {
        
        // Get product metadata
        Purchases.shared.getOfferings { (offerings, error) in
            if let package = offerings?.current?.lifetime?.storeProduct {
                self.productPrice = package.localizedPriceString
            } else {
                self.errorMessage = "There was an error fetching the product. Please, contact the developer at dmartin@dennistech.io."
                self.showingErrorAlert = true
            }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showingErrorAlert = true
            }
        }
    }
}
