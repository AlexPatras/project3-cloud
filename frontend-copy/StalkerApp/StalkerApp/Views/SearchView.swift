import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State var stalkers: [StalkerList] = []
    @State private var users: [User] = []
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return []
        } else {
            return users.filter { user in
                user.username.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Search for stalkers:")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                
                List(filteredUsers, id: \.id) { user in
                    HStack {
                        Text(user.username)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            Task {
                                do {
                                    guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
                                        print("JWT Token not available.")
                                        return
                                    }
                                    await addStalker(token: token, user: user)
                                }
                            }
                            
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .searchable(text: $searchText)
                
            }
            .onAppear {
                Task {
                    do {
                        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
                            print("JWT Token not available.")
                            return
                        }
                        let fetchedUsers = try await getUsers(token: token)
                        users = fetchedUsers
                        print(fetchedUsers)
                    } catch {
                        print("Error fetching users \(error)")
                    }
                }
            }
        }
    }
    
    func addStalker(token: String, user: User) async {
        let useradded = user.id
        let usernameStalker = user.username
     
        
        do {
            try await addStalkerToList(token: token, stalkerId: useradded!, username: usernameStalker)
        } catch {
            print("Error adding user to stalker list - addStalkerToList: \(error)")
        }
    }
}
#Preview {
    SearchView()
}
