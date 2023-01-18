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
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    
                    HStack{
                        Text("200".uppercased())
                            .scoreNumberStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("High\nScore")
                            .scoreLabelStyle()
                            .modifier(ScoreNumberModifier())
                    } .modifier(ScoreContainerModifier())
                }
                
                
                
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
