//
//  BuyLivesModal.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 6/9/22.
//

import SwiftUI

struct BuyLivesModal: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                        
                }
            }
            .padding([.trailing, .top])
            
            Section {
                VStack(spacing: 20) {
                    Text("Buy lifes")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("Keep learning about countries.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Image("heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                        .padding(40)
                        .background(
                            Color.blue.opacity(0.5)
                                .cornerRadius(20)
                                .shadow(radius: 20)
                        )
                        .padding()
                    
                    VStack(spacing: 30) {
                        
                    }
                }
                .padding()
            } footer: {
                Text("GeoQuiz is an indie app made by just one person. I'm glad that you are considering buying lifes to keep playing GeoQuiz.")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
    }
}

struct BuyLivesView_Previews: PreviewProvider {
    static var previews: some View {
        BuyLivesModal()
    }
}
