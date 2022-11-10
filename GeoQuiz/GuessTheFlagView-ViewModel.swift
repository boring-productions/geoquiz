//
//  GuessTheFlagView-ViewModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/11/22.
//

import Foundation
import SwiftUI

extension GuessTheFlagView {
    
    class Layout {
        
        static func showFlag(in flagPath: String, geo: GeometryProxy, _ userController: UserController) -> some View {
            switch userController.data.guessTheFlagShape {
            case .respectAspectRatio:
                return AnyView(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white.opacity(0.5))
                        .frame(width: geo.size.height * 0.3, height: geo.size.height * 0.15)
                        .overlay(
                            Image(uiImage: UIImage(contentsOfFile: flagPath)!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding()
                        )
                )
            case .circular:
                return AnyView(
                    Image(uiImage: UIImage(contentsOfFile: flagPath)!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geo.size.height * 0.16)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                )
            case .rectangular:
                return AnyView(
                    Image(uiImage: UIImage(contentsOfFile: flagPath)!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.height * 0.3, height: geo.size.height * 0.15)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                )
            }
        }
    }
}
