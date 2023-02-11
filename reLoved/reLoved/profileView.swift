//
//  profileView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/10/23.
//

import SwiftUI

struct profileView: View {
    var body: some View {
        
        content
    }
    
    var content: some View {
        
        VStack{
            Text("Your Profile")
            HStack(spacing:100){
                Image("profile_01")
                    .resizable().frame(width: 64.0, height: 64.0)
                Text("Todd Sproull")
            }
            
        
           
           
        }
        
        
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
