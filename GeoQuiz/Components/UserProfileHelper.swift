//
//  UserProfileHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/10/22.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var userController: UserController
    @ObservedObject var storeKitController: StoreKitController
    
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            UserImage(userController: userController)
                .frame(height: 150)
                .shadow(radius: 10)
        
            VStack(spacing: 10) {
                Text(userController.data.username)
                    .font(.title.bold())
                
                if storeKitController.premiumIsActive {
                    Text("Premium user ⭐️")
                        .foregroundColor(.secondary)
                }
            }
            
            Button("Edit") {
                isShowing = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(userController: UserController(), storeKitController: StoreKitController(), isShowing: .constant(true))
    }
}
