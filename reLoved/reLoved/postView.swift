//
//  postView.swift
//  reLoved
//
//  Created by Chae Hun Lim on 2/12/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct postView: View {
    
    
    
    @State var itemName = ""
    @State var itemDescription = ""
    @State var price = ""
    @State var location = ""
    
    @StateObject var imagePicker = ImagePicker()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    var body: some View {
        
        VStack(spacing: 20){
            
            
                VStack{
                    ZStack{
                        
                        if let image = imagePicker.image{
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        PhotosPicker( selection: $imagePicker.imageSelection){
                            Label("Select a photo", systemImage: "photo")
                        
                        }.tint(.red)
                            .controlSize(.large)
                            .buttonStyle(.borderedProminent)
                        
                    }
                    
                    
                }.frame( width: 300,height: 300)
                .border(.red)
               
                
            
            TextField("Name", text: $itemName)
                .foregroundColor(.black)
                .textFieldStyle(.roundedBorder)
            ScrollView {
                HStack{
                    ForEach(PostModel.categories, id: \.self){
                        category in
                        Text(category)
                    }
                    
                    
                   

                }

                  
                
            }
            
            TextField("Description...", text: $itemDescription, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
            TextField("Price", text: $price)
                .foregroundColor(.black)
                .textFieldStyle(.roundedBorder)
            
            TextField("Location", text: $location)
                .foregroundColor(.black)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                post()
                //print(imagePicker.imageData)
                
            }, label: {
                Text("Post!")
                    .bold()
                    .frame(width: 200, height: 50)
                    .tint(.red)
                        .controlSize(.large)
                        .buttonStyle(.borderedProminent)
                    
            })
                        

                   
                       
            
        }.padding()
        
        
        
        
    }
    func post(){
        
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let postUID = UUID().uuidString
        let storageRef = storage.reference()
      
        guard let imageData = imagePicker.imageData?.jpegData(compressionQuality: 1.0) else { return }
        let fileRef = storageRef.child("images/\(postUID).jpg")
        let uploadTask = fileRef.putData(imageData,metadata: nil){
            metadata, error in
            if let error = error {
                print("Error uploading image: \(error)")

            }
            
            
        }
        db.collection("posts").document(postUID).setData([
            "uid": userUID,
            "name": itemName,
            "desc": itemDescription,
            "image-uid": postUID,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
            
        }
    }
}

struct postView_Previews: PreviewProvider {
    static var previews: some View {
        postView()
    }
}
