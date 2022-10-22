//
//  UserController.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 7/10/22.
//

import Foundation

class UserController: ObservableObject {
    @Published var data = UserDataModel() {
        didSet {
            if let userDataEncoded = try? JSONEncoder().encode(data) {
                UserDefaults.standard.set(userDataEncoded, forKey: "UserData")
            }
        }
    }

    init() {
        if let userData = UserDefaults.standard.data(forKey: "UserData") {
            if let decodedUserData = try? JSONDecoder().decode(UserDataModel.self, from: userData) {
                data = decodedUserData
            }
        }
    }
}
