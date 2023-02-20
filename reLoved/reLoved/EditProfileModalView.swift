//
//  EditProfileModalView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/19/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct EditProfileModalView: View {
    
    @Binding var isShowing: Bool
    @Binding var userUID:String
    @Binding var username:String
    
    @State var newUsername = ""
    @State var newEmail = ""
    @State var curHeight = 700;
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing {
                Color.black
                    .opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                .transition(.move(edge: .bottom))
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.linear(duration: 0.3))
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height:40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001 ))
            
            
            Text("Edit Profile Info").bold().padding(20)
            Spacer()
                ZStack {
                    VStack{
                        VStack(alignment: .leading){
                            Text("Username").padding(.leading, 20).padding(.bottom, 0)
                            TextField(username, text: $newUsername).border(Color.orange).frame(width: 300, height: 30).padding(.leading, 20)
                        }
                        
                        Button(action: updateProfileInfo, label: {
                            Text("Submit")
                                .bold()
                                .frame(width: 200, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(colors: [.orange,.orange], startPoint: .top, endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        })
                        .padding(100)
                    }
                    
                }
            }
        .frame(height: 700)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: 700/2)
            }
                .foregroundColor(.white)
        )
    }
    
   
        
        func updateProfileInfo() {
            let db = Firestore.firestore()
            
            db.collection("users").document(userUID).updateData([
                "name": newUsername,
            ]) {
                err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    username = newUsername
                    print("Document successfully updated!")
                }
                
            }
            isShowing = false
        }
    
    
}

struct EditProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileModalView(isShowing: .constant(true), userUID: .constant(""), username:.constant(""))
    }
}
