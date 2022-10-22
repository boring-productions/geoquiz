//
//  UserImageHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 22/10/22.
//

import SwiftUI

struct UserImage: View {
    @ObservedObject var userController: UserController
    
    var body: some View {
        if let uiImage = userController.data.uiImage {
            Circle()
                .overlay(
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                )
        } else {
            Circle()
                .foregroundColor(.secondary.opacity(0.3))
                .overlay(
                    Image(systemName: "person")
                        .font(.largeTitle)
                )
        }
    }
}

struct UserImage_Previews: PreviewProvider {
    static var previews: some View {
        UserImage(userController: UserController())
    }
}
