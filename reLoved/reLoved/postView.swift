//
//  postView.swift
//  reLoved
//
//  Created by Chae Hun Lim on 2/12/23.
//

import SwiftUI

struct postView: View {
    
    @State var itemName = ""
    @State var itemDescription = ""
    @State var itemImage = ""
    
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack{
            Text("reLoved")
                .font(.system(size: 50, weight: .medium, design: .default))
                .foregroundColor((.red))
                .padding(80)
            VStack(spacing: 10){
                
                TextField("Name", text: $itemName)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                Rectangle()
                    .frame(width:350, height:1)
                    .foregroundColor(.black)
                    .padding(.bottom)
                TextField("", text: $itemDescription)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                Rectangle()
                    .frame(width:350, height:1)
                    .foregroundColor(.black)
                    .padding(.bottom)
            }
        }
    }
    
}
struct postView_Previews: PreviewProvider {
    static var previews: some View {
        postView()
    }
}
