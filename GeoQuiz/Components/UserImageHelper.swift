//
//  UserImageHelper.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 18/10/22.
//

import SwiftUI

struct UserImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        if let uiImage = uiImage {
            Circle()
                .frame(height: 100)
                .overlay(
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                )
        } else {
            Circle()
                .frame(height: 100)
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
        UserImage()
    }
}
