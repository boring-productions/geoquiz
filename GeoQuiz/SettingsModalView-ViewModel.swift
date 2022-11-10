//
//  SettingsModalView-ViewModel.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 9/11/22.
//

import Foundation

extension SettingsModalView {
    func getVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
