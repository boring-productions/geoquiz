//
//  UserClass.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/10/22.
//

import Foundation

class User: ObservableObject {
    @Published var data = UserData() {
        didSet {
            if let userDataEncoded = try? JSONEncoder().encode(data) {
                UserDefaults.standard.set(userDataEncoded, forKey: "UserData")
            }
        }
    }

    init() {
        if let userData = UserDefaults.standard.data(forKey: "UserData") {
            if let decodedUserData = try? JSONDecoder().decode(UserData.self, from: userData) {
                data = decodedUserData
            }
        }
    }
}
