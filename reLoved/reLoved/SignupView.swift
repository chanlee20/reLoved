//
//  SignupView.swift
//  reLoved
//
//  Created by 이찬 on 2/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct SignupView : View{
    //state variables
    @State var email = ""
    @State var name = ""
    @State var pwd = ""
    @State var verified_pwd = ""
    @State var userSignedUp = false;
   

    let db = Firestore.firestore()
   

    var body: some View{
            if userSignedUp {
                //alert signup was completed
                LoginView()
            }
            else{
                //if user didn't sign up yet
                content
            }
    }
    var content: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.orange, .white]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                Text("reLoved")
                    .font(.system(size: 50, weight: .medium, design: .default))
                    .foregroundColor((.red))
                    .padding(80)
                VStack(spacing: 10){
                    Image(systemName: "arrow.clockwise.heart")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                        .padding(.bottom)
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    TextField("Name", text: $name)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    SecureField("Password (6 characters or longer)", text: $pwd)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.white)
                        .padding(.bottom)

                    SecureField("Re-Enter Password", text: $verified_pwd)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.white)
                    Button(action: {
                        register()
                    }, label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(colors: [.orange,.orange], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    })
                    

                    .padding(.top)
                    .offset(y: 20)
                }
                
            }
            
            .frame(width: 350)
            Spacer()
            
        }
        .ignoresSafeArea()
    }
    
    //sign up
    func register() {
        
        if(!email.contains("@wustl.edu")){
            print("invalid email domain")
            //alert box later
            
            return
        }
        if(verified_pwd != pwd){
            print("wrong passwords")
            //should eventually alert that the user failed to register
            return
        }
        
        
        
        
        userSignedUp = true
        
        Auth.auth().createUser(withEmail: email, password: pwd){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            guard let userUID = result?.user.uid else {return}
            db.collection("users").document(userUID).setData([
                "name": name,
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    print(db.collection("users").document(userUID).value(forKey: "name")!)

                }
            }
            
            
        }
        
       
       
        
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
