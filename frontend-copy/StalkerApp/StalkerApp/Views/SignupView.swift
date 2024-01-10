//
//  ContentView.swift
//  stalker
//
//  Created by Sarah Largou on 08.11.23.
//

import SwiftUI

struct SignupView: View {
    @Binding var showSignup: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var phoneNr = ""
    @State private var showingLoginScreen = false
    @State private var showAddAddress: Bool = false
    @State private var token: String?


    var body: some View {
        // vstack is for vertical alignment as the V indicates
        // top to bottom basically
        VStack(alignment: .center, spacing: 15, content: {
            // back button
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    
            })
                Image("app_logo")
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, 40)
                    .padding(.top, 25)
                    .frame(width: 150, height: 150)
                    
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Please sign up to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                
            VStack(spacing: 25){
                    // custom text fields
                    
                    CustomTextFields(sfIcon: "person", hint: "first name", value: $firstname)
                    CustomTextFields(sfIcon: "person", hint: "last name", value: $lastname)
                    CustomTextFields(sfIcon: "phone", hint: "phone number", value: $phoneNr)
                    CustomTextFields(sfIcon: "at", hint: "username", value: $username)
                    
                    CustomTextFields(sfIcon: "lock", hint: "password", isPassword: true, value: $password)
                        .padding(.top, 5)
                // hstack is for horizontal alignment
                // leading to trailing basically
                HStack{
                    Text("Already have an account?")
                    Button("Login"){
                        showSignup = false
                    }
                    .font(.callout)
                }
                
                //signup button
            
                CustomButton(title: "Continue", icon: "arrow.right") {
                    Task {
                        do {
                            //does not already return token
                            token = try await signUp()
                                    
                            showAddAddress = true
                        
                        } catch {
                            print("Error \(error)")
                        }
                    }
                }
                // needs to lead to add address but that doesnt work yet
                NavigationLink(destination: LoginView(showSignup: $showSignup), isActive: $showAddAddress){
                    EmptyView()
                }
                
                
                // planning to implement disabling the button until data is entered here
                
                
            }
                .padding(.top, 20)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        
    }
    
// hi new line for commit 
func signUp() async throws -> String {
    
    // could url be the issue ??
    let url = "http://127.0.0.1:3000/signup"
    
    let userData = User (
        firstname: firstname,
        lastname: lastname,
        username: username,
        password: password,
        phoneNr: phoneNr
        )
    // print url for debugging
    print("URL: \(url)")
    // make sure data isnt missing/left empty
    if(firstname.isEmpty || lastname.isEmpty ||   phoneNr.isEmpty){
        throw RequestError.missingData
    }
        // do the request 
        do {
            try await postSignup(urlString: url, user: userData)
            print("Signup Successful")
            
        }catch RequestError.missingData{
            print("Error \(RequestError.missingData)")
            print(userData)
            throw RequestError.missingData
        }catch {
            print("Error \(error)")
            print(userData)
        }
    return userData.username
    }
}


#Preview {
    ContentView()
}
