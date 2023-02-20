//
//  EditProfileModalView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/19/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct EditProfileModalView: View {
    
    @Binding var isShowing: Bool
    @Binding var userUID:String
    @Binding var username:String
    
    @StateObject var imagePicker = ImagePicker()
    
    @State var newUsername = ""
    @State var newEmail = ""
    @State var curHeight = 700;
    @State var profileImage:Image = Image("")

    
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
                    VStack{
                        ZStack{
                            
                            if let image = imagePicker.image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                                    
                                    
                            }
                            PhotosPicker( selection: $imagePicker.imageSelection){
                                Label("Change profile pic", systemImage: "photo")
                            
                            }.tint(.gray)
                                .controlSize(.regular)
                                .buttonStyle(.borderedProminent)
                            
                        }
                    }.frame( width: 240,height: 240)
                            .cornerRadius(100)
                    .border(.gray)
                   
                        
                        
                        
                        VStack(alignment: .leading){
                            Text("Username").padding(.leading, 20).padding(.bottom, 0)
                            TextField(username, text: $newUsername)
                                .foregroundColor(.black).border(Color.gray).opacity(0.5).frame(width: 300, height: 30).padding(.leading, 20)
                                .textFieldStyle(.roundedBorder)
                                
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
            let storage = Storage.storage()
            
            let postUID = UUID().uuidString
            let storageRef = storage.reference()

            // UPDATING PROFILE PIC
            // update image file in storage
            guard let imageData = imagePicker.imageData?.jpegData(compressionQuality: 1.0) else { return }
            
            let fileRef = storageRef.child("profile/\(postUID).jpg")
            let uploadTask = fileRef.putData(imageData,metadata: nil){
                metadata, error in
                if let error = error {
                    print("Error uploading image: \(error)")
                }
            }
            // update imageUID in database
            db.collection("users").document(userUID).setData([
                "image-uid": postUID,
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
                
            }
            
            
            // UPDATING USERNAME
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
