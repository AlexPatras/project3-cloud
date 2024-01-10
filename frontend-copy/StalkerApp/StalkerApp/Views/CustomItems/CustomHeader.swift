//
//  CustomHeader.swift
//  StalkerApp
//
//  Created by Sarah Largou on 23.12.23.
//

import SwiftUI

struct CustomHeader: View {
    @State private var showSignup: Bool = false
    var body: some View {
        
      

        
        // this is just an offer to use this as a header.
        // makes it reusable in case we need it in other views
        HStack{
            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink(destination:  LoginView(showSignup: $showSignup).navigationBarBackButtonHidden(true)) {
                Image(systemName: "line.3.horizontal")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 50, height: 50)
            }
            .onTapGesture {
                // Perform logout actions
                UserDefaults.standard.removeObject(forKey: "jwtToken")
            }
        }
        .background()
        .cornerRadius(10)
        .padding(.top, -5)
        .padding(.bottom, -5)
                  
        
    }
}

#Preview {
    CustomHeader()
        .previewLayout(.fixed(width: 60, height: 60))
}
