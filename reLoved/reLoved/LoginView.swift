//
//  ContentView.swift
//  reLoved
//
//  Created by 이찬 on 2/5/23.
//

import SwiftUI
import Firebase

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginView: View{
    //state variables to check user status
    @State var email = ""
    @State var pwd = ""
    @State var userLoggedIn = false;
    
    var body: some View{
        //navigation view to use navigation link at line 75
        NavigationView(content: {
            if userLoggedIn {
                MainView()
            }
            else{
                content
            }
        })
    }

    var content: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.white, .white]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
//                Text("reLoved")
                VStack(spacing: 20){
//                    Image(systemName: "arrow.clockwise.heart")
//                        .renderingMode(.original)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 180, height: 180)
                    
                    Image("reLoved")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 180)
                    TextField("Email", text: $email)
                        .foregroundColor(.purple)
                        .textFieldStyle(.plain)
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.purple)
                    SecureField("Password", text: $pwd)
                        .foregroundColor(.purple)
                        .textFieldStyle(.plain)
                        
                    Rectangle()
                        .frame(width:350, height:1)
                        .foregroundColor(.purple)
                    Button(action: {
                        login()
                    }, label: {
                        Text("Sign In")
                            .bold()
                            .frame(width: 200, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(colors: [.purple,.purple], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    })
                    .padding(.top)
                    .offset(y: 40)
                    NavigationLink(destination: SignupView(), label: {Text("Don't have an account?")})
                        .offset(y: 30)
                        .foregroundColor(.purple)
                    
                }
            }
            .frame(width: 350)
            Spacer()
        }
        .ignoresSafeArea()
        //every time screen appears check if the user has already logged in
        .onAppear{
            Auth.auth().addStateDidChangeListener { auth, user in
              if user != nil {
                  userLoggedIn = true;
              } else {
                  userLoggedIn = false;
              }
            }
        }
    }
    //login
    func login(){
        Auth.auth().signIn(withEmail: email, password: pwd){ result, error in
            if(error != nil){
                print(error!.localizedDescription)
                userLoggedIn = false
            }
            else{
                userLoggedIn = true
            }
        }
    }
}
