//
//  User.swift
//  StalkerApp
//

//  Created by Patras Alexandru on 05.12.2023.

//

import Foundation


struct User:Codable, Hashable {
    
    var id: Int? = nil
    var firstname: String
    var lastname:String
    var username:String
    var password:String
    var phoneNr:String
    var Address: [Address]?
    

    
}

