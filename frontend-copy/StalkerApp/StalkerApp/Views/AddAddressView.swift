//
//  AddAddressView.swift
//  stalker
//
//  Created by Sarah Largou on 08.11.23.
//

import SwiftUI

struct AddAddressView: View {
    
    @Binding var showSignup: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showingLoginScreen = false
    //@State private var showHomeView = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 15, content: {
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)

                Image("app_logo")
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, 40)
                    .frame(width: 150, height: 150)
                    
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Please sign in to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                
            VStack(spacing: 25){
                    // custom text fields
                    CustomTextFields(sfIcon: "at", hint: "username", value: $username)
                    
                    CustomTextFields(sfIcon: "lock", hint: "password", isPassword: true, value: $password)
                        .padding(.top, 5)
                HStack{
                    Text("Don't have an account?")
                    Button("SignUp"){
                        showSignup.toggle()
                    }
                    .font(.callout)
                }
                
                //login button
              /*  NavigationLink(destination: AddAddressView(), isActive: $showHomeView){
                    EmptyView()
                }        */
                CustomButton(title: "Login", icon: "arrow.right") {
                    
                }
                
                // planning to implement disabling the button until data is entered here not sure how tho
                
                
            }
                .padding(.top, 20)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        
    }
}
/*
func login() async throws -> String {
    let urlString = "http://[::1]:3000/users/login"
    let userLogin = UserLogin(
        username: username,
        password: password
    )
    var returnToken = ""
    do {
        returnToken = try await postLogin(urlString: urlString, loginUser: userLogin)
        print("Login successful \n"+returnToken)
        return returnToken
    }catch RequestError.unauthorized{
        print("Error \(RequestError.unauthorized)")
        print(userLogin)
        throw RequestError.unauthorized
    } catch {
        
        print("Error \(error)")
        print(userLogin)
        
        throw RequestError.unknown
        
    }
    return returnToken
}

*/
#Preview {
    AddAddressView()
}

