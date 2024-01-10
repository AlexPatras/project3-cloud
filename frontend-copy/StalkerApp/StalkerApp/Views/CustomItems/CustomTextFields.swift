//
//  CustomTextFields.swift
//  StalkerApp
//
//  Created by Sarah Largou on 13.12.23.
//

import SwiftUI
// text  fields i'd like to have used in views where they are necessary
struct CustomTextFields: View {
    
    var sfIcon: String
    var iconTint : Color = .gray
    var hint: String
    /// hide textfield 
    var isPassword: Bool = false
    @Binding var value: String
    /// view properties
    @State private var showPassword: Bool = false
    var body: some View {
        
        HStack(alignment: .top, spacing: 8,  content: {
            // the icon at the start of the textfield. can be left empty in the method later. its optional
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                .frame(width: 30)
                .offset(y: 2)
            
            
            VStack(alignment: .leading, spacing: 8, content: {
                // checks if the textfield is for passwords. if its not its a simple textfield if it is its a securefield
                // securefields dont show the content of the input
                if isPassword {
                    Group{
                        // to reveal pw if user wants to
                        if showPassword {
                            TextField(hint, text: $value)
                        } else {
                            SecureField(hint, text: $value)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                    
                }
                Divider()
            })
            .overlay(alignment: .trailing) {
                // another thing i added is that if you want to check what you typed in as password you can click the button with the eye and it converts the securefield to a textfield and vice versa
                if isPassword{
                    Button(action: {
                        withAnimation{
                            showPassword.toggle()
                        }
                    }, label: {
                        // ternary operator btw. simple if clause in one line
                        // better explanation: checks if showPassword is true or false and depending on the value it passes eyeslash or eye 
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
           
            
               })
    }
}


