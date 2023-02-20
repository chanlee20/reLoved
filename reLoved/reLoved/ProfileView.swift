//
//  profileView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/10/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct ProfileView: View {
    @ObservedObject var imageLoader = FirebaseImageLoader()
    @State var loggedout = false
    var auth = Auth.auth()
    let db = Firestore.firestore()
    @State var userUID = Auth.auth().currentUser?.uid ?? ""
    @State var username = ""
    @State var profileImage: UIImage? = nil
    @State var showModal = false
   

    var body: some View {
        content
        
            .onAppear {
                let _ = self.fetchUserData()
            }
        
    }
    var content: some View {
        
        ZStack {
            
            VStack{
                
                NavigationView {
                        
                        VStack{
                            
                            if let profileImage = profileImage {
                                        Image(uiImage: profileImage)
                                            .resizable()
                                            .frame(width: 200.0, height: 200.0).cornerRadius(100).padding(.top, 20)
                                    } else {
                                        // Show a placeholder or loading indicator if the image is not yet available
                                        Text("Loading...")
                                    }
                                
                            Text(auth.currentUser?.email ?? "email not found")
                                .padding([.bottom, .top], 1)
                            Text(username)
//                            Spacer()
                            
                        }
                        
                        .navigationTitle("Your Profile")
                        .padding(30)
                        .cornerRadius(40)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray, lineWidth: 5)
                        )
                    }
                Button(action: {showModal = true}, label: {
                    Text("Edit Profile")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(colors: [.orange,.orange], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                })
                
                
                
                Button(action: {logout()}, label: {
                    Text("Log out")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(colors: [.orange,.orange], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                })
            }
        
            EditProfileModalView(isShowing: $showModal, userUID: $userUID, username: $username)
           
        }
        
        .onAppear{
            self.fetchUserData()
        }
    }
    
    
    func fetchUserData()  {
        
        
        // fetch user's username from firestore
        let docRefUsers = db.collection("users").document(userUID)
        let storageRef = Storage.storage().reference()
        
        
        docRefUsers.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.username = data["name"] as? String ?? ""
                    let imageUID = data["image-uid"] ?? "default"
                    
                    imageLoader.loadImage(path: "profile/\(imageUID).jpg") { imageData in
                        if let imageData = imageData {
                            let uiImage = UIImage(data: imageData)
                            self.profileImage = uiImage
                        }
                    }
                }
            }
        }
    }
    
    func logout() {
        do{
            try Auth.auth().signOut()
            loggedout = true
        }
        catch{
            loggedout = false
            print("failed to logout")
        }
       
    }
    
    
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


class FirebaseImageLoader: ObservableObject {
    func loadImage(path: String, completion: @escaping (Data?) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference().child(path)
        reference.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                completion(data)
            }
        }
    }
}





