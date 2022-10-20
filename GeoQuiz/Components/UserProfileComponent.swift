//
//  UserProfileComponent.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/10/22.
//

import SwiftUI

struct UserProfile: View {
    @ObservedObject var user: User
    @ObservedObject var storeKitRC: StoreKitRC
    
    var body: some View {
        HStack(spacing: 20) {
            UserImage(uiImage: user.data.uiImage)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.data.username)
                    .font(.title)
                    .fontWeight(.semibold)
                
                if storeKitRC.isActive {
                    Text("Premium user ⭐️")
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(user: User(), storeKitRC: StoreKitRC())
    }
}
