//
//  ContentView.swift
//  StalkerApp
//
//  Created by constantinescu alex on 15.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showSignup: Bool = false
    var body: some View {
        NavigationStack{
            LoginView(showSignup: $showSignup)
                .navigationDestination(isPresented: $showSignup){
                    SignupView(showSignup: $showSignup)
                }            
        }
    }
}

#Preview {
    ContentView()
}
