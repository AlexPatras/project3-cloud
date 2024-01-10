
//  HomePageView.swift
//  StalkerApp
//  Created by Patras Alexandru on 26.11.2023.

import SwiftUI

struct HomePageView: View {
    @State private var showingSheet = false
    @State private var users: [User] = []
    @State var stalkers: [StalkerList] = []
    
    var body: some View {
        NavigationView{
            // Zstack allows overlaying on the Z axis.
            // order of views determines their placements btw
            ZStack{
                Color(UIColor.systemBackground)
                    .ignoresSafeArea(.all)
                CustomMapView()
                VStack(alignment: .leading) {
                    
                    
                    CustomHeader()
                        .padding()
                    
                    Spacer()
                    Button(action: {
                        showingSheet.toggle()
                        
                    }) {
                        Image(systemName: "person.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .sheet(isPresented: $showingSheet) {
                        BottomSheetView()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    }
                }
            }
            
        }
    }
    struct BottomSheetView: View {
        @State var searchText = ""
        @State var stalkers: [StalkerList] = []
        
        var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("STALKERS")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    List {
                        if stalkers.isEmpty {
                            Text("No stalker added!")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(stalkers, id: \.self) { stalker in
                                Text(stalker.username)
                            }
                        }
                    }
                    .searchable(text: $searchText)
                    .scrollContentBackground(.hidden)
                    
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    do {
                        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
                            print("JWT Token not available.")
                            return
                        }
                        stalkers.removeAll()
                        stalkers = try await getStalkers(token: token, url: "http://[::1]:3000/users/1/stalker-list")
                    } catch {
                        print("Error fetching stalkers: \(error)")
                    }
                }
            }
        }
    }
}
#Preview {
    HomePageView()
}
