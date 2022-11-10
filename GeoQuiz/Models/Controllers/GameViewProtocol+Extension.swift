//
//  GameViewProtocol+Extension.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/11/22.
//

import Foundation

protocol GameView {

}

extension GameView {
    func getFlagPath(forName flagName: String) -> String {
        return Bundle.main.path(forResource: flagName, ofType: "png")!
    }
    
}
