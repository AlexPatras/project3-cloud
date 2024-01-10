//
//  UserLogin.swift
//  StalkerApp
//
//  Created by Sarah Largou on 14.12.23.
//

import Foundation

// necessary for the postlogin request. i tried a different approach but that one had errors so lets do this.

struct UserLogin: Codable, Hashable {
    var username: String
    var password: String
}
