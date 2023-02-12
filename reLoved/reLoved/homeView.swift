//
//  homeView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/10/23.
//

import SwiftUI

struct homeView: View {
    var body: some View {
       content
    }
    var content: some View {
        
        HStack{
            NavigationLink(destination: postView(), label: {Text("post")})
            
        }
        
        
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
