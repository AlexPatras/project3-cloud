//
//  UserRequest.swift
//  StalkerApp
//
//  Created by Tiberiu Velcea on 29/11/2023.
//

import Foundation

enum RequestError: Error {
case invalidURL
case missingData
case httpError
}

func getUsers(urlString: String) async throws -> [User]{
    guard let url = URL(string: "\(urlString)users") else {
        throw RequestError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode else {
        throw RequestError.httpError
    }
    let users = try JSONDecoder().decode([User].self, from: data)
    return users
    
}
