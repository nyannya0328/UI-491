//
//  Home.swift
//  UI-491
//
//  Created by nyannyan0328 on 2022/03/04.
//

import SwiftUI

struct Home: View {
    
    @State var animatedValue : [Bool] = Array(repeating: false, count: 3)
    
    @Namespace var animation
    
    @State var currentDate : Date = Date()
    
    
    var body: some View {
        ZStack{
            
            
            if !animatedValue[0]{
            
            
            RoundedRectangle(cornerRadius:animatedValue[0] ? 30 : 0, style: .continuous)
                .fill(Color("Purple"))
                .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                .ignoresSafeArea()
            
            
            
            Image("Logo")
               
                .scaleEffect(animatedValue[0] ? 0.25 : 1)
                .matchedGeometryEffect(id: "SPLASHLOGO", in: animation)
                
            }
            
            
            if animatedValue[0]{
                
                VStack(spacing:0){
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "rectangle.lefthalf.inset.filled")
                            .font(.system(size: 20, weight: .semibold))
                           
                    }
                    .frame(maxWidth:.infinity,alignment: .trailing)
                    .foregroundColor(.black)
                    
                    .overlay{
                        
                        
                        Text("All Debts")
                            .font(.title3.weight(.semibold))
                    }
                    .padding(.bottom,20)
                    
                    
                    CustomDatePicker(currentDate: $currentDate)
                        .overlay(alignment: .topLeading, content: {
                            
                            
                            Image("Logo")
                                .scaleEffect(0.2)
                                .matchedGeometryEffect(id: "SPLASHLOGO", in: animation)
                                .offset(x: -20, y: -20)
                                
                        })
                        .background{
                    
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color("Purple"))
                        .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                            
                        }
                    
                                    ScrollView(.vertical, showsIndicators: false) {
                    
                    
                                        VStack(spacing:20){
                    
                                            ForEach(users){user in
                    
                    
                                                UserCardView(user: user, index: getIndex(user: user))
                    
                    
                    
                                            }
                    
                    
                    
                    
                                        }
                                        .padding(.top,30)
                    
                    
                                    }


                    
                }
                .padding([.horizontal,.top])
               
                


                
                
            }
                
                
            
        }
        .onAppear {
            
            startAnimation()
        }
    }
    func startAnimation(){
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.8)){
                
                
                
                animatedValue[0] = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animatedValue[1] = true
                
               
                
                
            }
            
            
            
        }
        
        
    }
    
    func getIndex(user : User)->Int{
        
        return users.firstIndex { currentUser in
            
            
            currentUser.id == user.id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
