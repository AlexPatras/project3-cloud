//
//  ContentView.swift
//  stalker
//
//  Created by Sarah Largou on 08.11.23.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showSignup: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showingLoginScreen = false
    @State private var showHomeView = false
    @State private var token: String? //optional
    
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
                CustomButton(title: "Login", icon: "arrow.right") {
                    Task {
                        do {
                            token = try await login()
                            if let unwrappedToken = token, !unwrappedToken.isEmpty {
                                showHomeView = true
                            }
                            
                        } catch {
                            print("Error \(error)")
                        }
                    }
                }
                NavigationLink(destination: HomePageView(), isActive: $showHomeView){
                    EmptyView()
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
    func login() async throws -> String {
        
        let userLogin = UserLogin (
            username: username,
            password: password
        )
        var serverResponse = ""
        // do the request
        do {
            serverResponse = try await postLogin(username: username, password: password)
            print("Login Successful. Token:  \n"+serverResponse)
            UserDefaults.standard.set(serverResponse, forKey: "jwtToken")
        }catch RequestError.unauthorized{
            print("Error \(RequestError.unauthorized)")
            print(userLogin)
            throw RequestError.unauthorized
        }catch {
            print("Error \(error.localizedDescription)")
            print(userLogin)
        }
        return serverResponse
    }
}
#Preview {
    ContentView()
}
