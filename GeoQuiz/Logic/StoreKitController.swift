//
//  StoreKitController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/10/22.
//

import Foundation
import RevenueCat

class StoreKitController: ObservableObject {
    @Published var errorAlertTitle = ""
    @Published var errorAlertMessage = ""
    
    @Published var showingErrorAlert = false
    @Published var showingSuccessAlert = false
    @Published var showingActivityAlert = false
    
    @Published var offerings: Offerings? = nil
    @Published var customerInfo: CustomerInfo? {
        didSet {
            premiumIsActive = customerInfo?.entitlements["Premium"]?.isActive == true
        }
    }
    
    @Published var premiumIsActive = false
    
    init() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            self.customerInfo = customerInfo
        }
    }
    
    func buy(_ package: Package) {
        showingActivityAlert = true
        
        Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
            if customerInfo?.entitlements["Premium"]?.isActive == true {
                self.showingSuccessAlert = true
            }
            
            if let error = error as? RevenueCat.ErrorCode {
                switch error {
                case .purchaseCancelledError:
                    self.errorAlertTitle = "Purchase cancelled"
                    self.errorAlertMessage = ""
                    self.showingErrorAlert = true
                default:
                    self.errorAlertTitle = "The purchase failed"
                    self.errorAlertMessage = "If the problem persists, contact me at dmartin@dennistech.io"
                    self.showingErrorAlert = true
                }
            }
            
            self.customerInfo = customerInfo
            self.showingActivityAlert = false
        }
    }
    
    func restorePurchase() {
        showingActivityAlert = true
        
        Purchases.shared.restorePurchases { customerInfo, error in
            if customerInfo?.entitlements["Premium"]?.isActive == true {
                self.showingSuccessAlert = true
            } else {
                self.errorAlertTitle = "Opps!"
                self.errorAlertMessage = "You don't have GeoQuiz Premium unlocked."
                self.showingErrorAlert = true
            }
            
            if let _ = error {
                self.errorAlertTitle = "The purchase couldn't be restored"
                self.errorAlertMessage = "If the problem persists, contact me at dmartin@dennistech.io"
                self.showingErrorAlert = true
            }
            
            self.customerInfo = customerInfo
            self.showingActivityAlert = false
        }
    }
    
    func fetchOfferings() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let _ = error {
                self.errorAlertTitle = "The product couldn't be fetched"
                self.errorAlertMessage = "If the problem persists, contact me at dmartin@dennistech.io"
                self.showingErrorAlert = true
            }
            
            self.offerings = offerings
        }
    }
}
