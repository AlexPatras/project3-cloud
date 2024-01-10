//
//  CustomButton.swift
//  StalkerApp
//
//  Created by Sarah Largou on 13.12.23.
//

import SwiftUI
// custom button so that our buttons are all the same
struct CustomButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    // you can add a navigationlink after the button call in your view. the button will function no worries. if done correctly of course.
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title) // title/text of your button
                Image(systemName: icon) // optional icon if you want to add one
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(Color(.black), in: .capsule)
        })

    }
}

#Preview {
    ContentView()
}
