//
//  SettingsModalView-ViewModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/11/22.
//

import Foundation

extension SettingsModalView {
    class ViewModel {
        var lives: [Int] {
            var lives = [Int]()
            for i in stride(from: 5, to: 55, by: 5) {
                lives.append(i)
            }
            
            return lives
        }
        
        func getVersion() -> String? {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        }
    }
}
