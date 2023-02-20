//
//  MainView.swift
//  reLoved
//
//  Created by 이찬 on 2/10/23.
//

import SwiftUI
import Firebase
struct MainView: View {
    @State var loggedout = false
    
    var body: some View{
        //if logout go to login page
        if loggedout {
            LoginView()
        }
        else{
            content
        }
    }
    
    var content: some View {
        
        VStack{
            
            TabView {
                homeView().tabItem{
                    Image(systemName: "Home")
                    Text("Home")
                }
                chatView().tabItem{
                    Image(systemName: "Chat")
                    Text("Chat")
                }
                likedView().tabItem{
                    Image(systemName: "Liked")
                    Text("Liked")
                }
                ProfileView().tabItem{
                    Image(systemName: "Profile")
                    Text("Profile")
                }
            }
            
        }
        
        
    }
    
    //logout
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
