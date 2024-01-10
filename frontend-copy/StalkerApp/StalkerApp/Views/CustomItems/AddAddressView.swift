//
//  AddAddress.swift
//  StalkerApp
//
//  Created by Sarah Largou on 20.12.23.
//

import SwiftUI

struct AddAddressView: View {
    @State private var country = ""
    @State private var city = ""
    @State private var postcode = ""
    @State private var street = ""
    @State private var streetNr = ""
    @State private var token: String?
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 15, content: {
            Image("app_logo")
                .resizable()
                .scaledToFill()
                .padding(.vertical, 40)
                .padding(.top, 25)
                .frame(width: 150, height: 150)
            
            Text("Address")
                .font(.title)
                .fontWeight(.bold)
            Text("Please add your address to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                CustomTextFields(sfIcon: "flag", hint: "Country", value: $country)
                CustomTextFields(sfIcon: "info", hint: "City", value: $city)
                CustomTextFields(sfIcon: "location", hint: "Postcode", value: $postcode)
                CustomTextFields(sfIcon: "rectangle", hint: "Street", value: $street)
                CustomTextFields(sfIcon: "number", hint: "Street Nr,", value: $streetNr)
            }
            
            CustomButton(title: "Continue", icon: "arrow.right"){
                /*
                Task {
                    do {
                        token = try await addAddress()
                    }
                }*/
                //Task {
                   // do {
                        //token = try await login()
                        //print("Token: " + token!)
                        //UserDefaults.standard.set(token, forKey: "jwtToxen")
                          //  showHomeView = true
                   
                   // } catch {
                   //     print("Error \(error)")
                   // }
               // }
                
            }
            
            .padding(.top, 20)
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)

            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        
    }
    
    func addAddress() async throws -> String {
        
        // could url be the issue ??
        let url = "http://[::1]:3000/addresses"
        
        let addressData = Address (
            country: country,
            city: city,
            postcode: postcode,
            street: street,
            streetNr: streetNr
            )
        // print url for debugging
        print("URL: \(url)")
       
            // do the request
            do {
                try await postAddress(urlString: url, address: addressData)
                print("Added Address")
                
            }catch RequestError.missingData{
                print("Error \(RequestError.missingData)")
                print(addressData)
                throw RequestError.missingData
            }catch {
                print("Error \(error)")
                print(addressData)
            }
        return addressData.city
        }
    
}

#Preview {
    AddAddressView()
}
