//
//  AddressRequests.swift
//  StalkerApp
//
//  Created by Sarah Largou on 21.12.23.
//

import Foundation


func postAddress(urlString: String, address: Address) async throws {
    
    //first check url
    guard let url = URL(string: "\(urlString)") else {
        throw RequestError.invalidURL
    }
    
    // create request and configure before sending
    var request = URLRequest(url: url)
    // setting content type so that the service knows to expect json
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //set method to post
    request.httpMethod = "POST"
    
    // converting user object to a data object
    let data = try JSONEncoder().encode(address)
    //attach data object to the request
    request.httpBody = data
    
    //do the request
    // create a data task with data method
    
    let (_, response) = try await URLSession.shared.data(for: request)

    guard let statusCode = response as? HTTPURLResponse, (200...299) ~= statusCode.statusCode else {
        
        let code = (response as? HTTPURLResponse)!.statusCode
        print(code)
        // throw error if request could not be processed. just check wikipedia for the list of errorcodes
        switch code {
        case 400: throw RequestError.missingData
        case 401: throw RequestError.unauthorized
        case 402...499: throw RequestError.unexpectedStatusCode
        case 500...510: throw RequestError.internalErr
        default: throw RequestError.unknown
        }
        
    }
}
