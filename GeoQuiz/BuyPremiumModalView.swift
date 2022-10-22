//
//  BuyPremiumModalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/10/22.
//

import SwiftUI

struct BuyPremiumModalView: View {
    @ObservedObject var storeKitController: StoreKitController
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20) {
                        VStack(spacing: 20) {
                            Text("Unlock all games 🤩")
                                .font(.largeTitle.bold())
                            
                            Text("Unlock three more game modes to become a geography master and support the future development of GeoQuiz.")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 400)
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Group {
                                    Image("GuessTheCapital")
                                        .resizable()
                                    
                                    Image("GuessTheCountry")
                                        .resizable()
                                    
                                    Image("GuessThePopulation")
                                        .resizable()
                                }
                                .scaledToFit()
                                .cornerRadius(25)
                                .frame(height: 500)
                            }
                            .padding()
                        }
                        
                        VStack(spacing: 10) {
                            Text("A one-time payment.")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("No subscriptions.")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                            
                            VStack {
                                if let package = storeKitController.offerings?.current?.lifetime {
                                    Button {
                                        storeKitController.buy(package)
                                    } label: {
                                        Text("Buy for \(package.storeProduct.localizedPriceString)")
                                            .font(.headline)
                                            .padding()
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding(.top)
                                } else {
                                    ProgressView()
                                }
                            }
                            
                            Button("Restore purchases", action: storeKitController.restorePurchase)
                        }
                        .padding()
                        
                        VStack {
                            Text("GeoQuiz is an indie game")
                            Text("I appreciate your support ❤️")
                        }
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding()
                    }
                }
                
                if storeKitController.showingActivityAlert {
                    ActivityAlert()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: storeKitController.fetchOfferings)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Exit", systemImage: "multiply")
                    }
                }
            }
        }
        .disabled(storeKitController.showingActivityAlert)
        .interactiveDismissDisabled(storeKitController.showingActivityAlert)
        
        .alert(storeKitController.errorAlertTitle, isPresented: $storeKitController.showingErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(storeKitController.errorAlertMessage)
        }
        
        .alert("GeoQuiz Premium is active!", isPresented: $storeKitController.showingSuccessAlert) {
            Button("OK", role: .cancel) { dismiss() }
        } message: {
            Text("Thanks for supporting indie apps ❤️")
        }
    }
}

struct BuyPremiumModalView_Previews: PreviewProvider {
    static var previews: some View {
        BuyPremiumModalView(storeKitController: StoreKitController())
    }
}
