//
//  profileView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ProfileView: View {
    @State var loggedout = false
    var auth = Auth.auth()
    let db = Firestore.firestore()
    @State var userUID = Auth.auth().currentUser?.uid ?? ""
    @State var username = ""
    @State var profileImage:Image = Image("")
    @State var showModal = false
    
    

    var body: some View {
        content
        let _ = self.fetchUserData()
    }
    var content: some View {
        
        ZStack {
            
            VStack{
                
                NavigationView {
                        
                        VStack{
                            profileImage.resizable().frame(width: 200.0, height: 200.0).cornerRadius(100).padding(.top, 20)
                            Text(auth.currentUser?.email ?? "email not found")
                                .padding([.bottom, .top], 1)
                            Text(username)
                            Spacer()
                            
                        }
                        
                        .navigationTitle("Your Profile")
                        
                    
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
           
           //comment
        }
        
    }
    
    
    func fetchUserData()  {
        
        
        // fetch user's username from firestore
        let docRefUsers = db.collection("users").document(userUID)
        
        docRefUsers.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.username = data["name"] as? String ?? ""
                    
                    // use default image if there's no profile image set
                    self.profileImage = data["image-uid"] as? Image ?? Image("profile_01")
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
