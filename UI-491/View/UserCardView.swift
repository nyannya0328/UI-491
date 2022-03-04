//
//  UserCardView.swift
//  UI-491
//
//  Created by nyannyan0328 on 2022/03/04.
//

import SwiftUI

struct UserCardView: View {
    
    var user : User
    var index : Int
    
    @State var showView : Bool = false
    
    var body: some View {
        HStack{
            
            
            Image(user.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text(user.name)
                    .fontWeight(.black)
                
                
                Text(user.type)
                    .fontWeight(.black)
                
                
                
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            
            Text(user.amount)
                .font(.title)
                .foregroundColor(user.color)
            
            
            
            
        }
        .padding(.vertical,5)
        .padding(.horizontal,5)
        .background(
        
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.gray,lineWidth: 1)
        
        )
        .offset(y: index > 8 ? 0 : showView ? 0 : 500)
        .onAppear {
            
            if index > 8 {return}
            
            
            withAnimation(.easeInOut(duration: 0.5).delay(Double(index) * 0.3)){
                
                showView = true
            }
        }
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
