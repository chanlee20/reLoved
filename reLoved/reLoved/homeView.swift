//
//  homeView.swift
//  reLoved
//
//  Created by Jiwoo Seo on 2/10/23.
//

import SwiftUI

struct homeView: View {
    @State private var image = UIImage()
    @State private var showSheet = false
    @State var showPostView: Bool = false

    var body: some View {
        VStack{
            if showPostView{
                postView()
            }else{
                Button("post"){
                    self.showPostView = true
                }
            }
        }
        
        
    }
   
        
        
    }


struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
