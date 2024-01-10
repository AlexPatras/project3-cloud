//
//  Address.swift
//  StalkerApp
//
//  Created by Sarah Largou on 20.12.23.
//

import Foundation

struct Address:Codable, Hashable {
        
    var id: Int? = nil
    var country: String
    var city: String
    var postcode: String
    var street: String
    var streetNr: String
    var userId: String?

}
