//
//  ContentView.swift
//  Slot-machine
//
//  Created by yeomim Kim on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            //interface
            VStack(alignment: .center, spacing: 5) {
                
                LogoView()
                
                Spacer()
                
                //header
                
                //score
                HStack{
                    Text("Your\nCoins".uppercased())
                        .foregroundColor(Color.white)
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                    Text("100")
                        .foregroundColor(Color.white)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
                        .layoutPriority(1)
                }
                .padding(.vertical,4)
                .padding(.horizontal, 16)
                .frame(minWidth: 128)
                .background(
                    Capsule()
                        .foregroundColor(Color("ColorTransparentBlack"))
                    )
                //slot machine
                //footer
                
                Spacer()
            }
            //buttons
            .overlay(
                Button(action: {
                    print("Reset the game")
                }){
                    Image(systemName: "arrow.2.circleapth.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            
            .overlay(
                //info
                Button(action: {
                    print("Info View")
                }) {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .padding()
            .frame(maxWidth: 720)
            
            //popup
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
