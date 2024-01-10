//
//  ProfileView.swift
//  StalkerApp
//
//  Created by Tiberiu Velcea on 21/12/2023.
//

//
//  ProfileView.swift
//  StalkerApp
//
//  Created by Tiberiu Velcea on 19/12/2023.
//
import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType?
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType ?? .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct InfoView: Identifiable {
    var id: Int
    let name, career, address, phone, youtube, email, website, instagram: String
}

struct ProfileView: View {
    @State private var image: UIImage?
    @State private var showSheet = false
    @State private var selectedSourceType: UIImagePickerController.SourceType?

    var info: [InfoView] = [
        .init(id: 0, name: "Reynaldo Manzanilla", career: "iOS Developer", address: "Private", phone: "+(49)-293 - 493 - 6548", youtube: "App Designer2", email: "app.designer2@gmail.com", website: "www.app-designer2.io", instagram: "@app_designer2")
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture").bold()) {
                    HStack {
                        Image(uiImage: self.image ?? UIImage())
                            .resizable()
                            .cornerRadius(50)
                            .padding(.all, 4)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .padding(15)
                        Text("Change profile picture")
                            .font(.headline)
                            .frame(width: 160, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(16)
                            .foregroundColor(.white)
                            .onTapGesture {
                                showSheet = true
                            }
                    }
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Change Profile Picture"), buttons: [
                            .default(Text("Take Photo"), action: {
                                self.selectedSourceType = .camera
                            }),
                            .default(Text("Choose from Gallery"), action: {
                                self.selectedSourceType = .photoLibrary
                            }),
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: Binding(
                        get: { selectedSourceType != nil },
                        set: { _ in selectedSourceType = nil }
                    )) {
                        if let sourceType = selectedSourceType {
                            ImagePicker(sourceType: sourceType, selectedImage: self.$image)
                        }
                    }
                }

                Section(header: Text("Personal Information").bold()) {
                    ForEach(info, id: \.id) { inf in
                        VStack(alignment: .leading) {
                            Text("Name: \(inf.name)").foregroundColor(.secondary)
                            Text("Email: \(inf.email)").foregroundColor(.secondary)
                            Text("Phone: \(inf.phone)").foregroundColor(.secondary)
                            Text("Address: \(inf.address)").foregroundColor(.secondary)
                            Text("Username: \(inf.career)").foregroundColor(.secondary)
                            Text("Instagram: \(inf.instagram)").foregroundColor(.secondary)
                            Text("Total stalkers: \(inf.youtube)").foregroundColor(.secondary)
                            Text("Stalker since: \(inf.website)").foregroundColor(.secondary)
                            
                            
                           
                        }
                       /*  
                        NavigationLink(destination: EditView() ){
                        Text("Edit")
                        }
                        */
                    }
                }
            }
            .navigationBarTitle("My Stalker Profile")
            .navigationBarItems(leading: NavigationLink(destination: HomePageView().navigationBarBackButtonHidden(true)){
                Text("Home")
            
            }, trailing: Button("Edit") {
                // Add your edit button logic here
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
