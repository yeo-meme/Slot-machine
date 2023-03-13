//
//  ContentView.swift
//  Slot-machine
//
//  Created by yeomim Kim on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    let symvols = ["gfx-bell","gfx-cherry","gfx-coin",
    "gfx-grape","gfx-seven","gfx-strawberry"]
    
    @State private var reels: Array = [0,1,2]
    //info showing View Button 이벤트
    @State private var showingInfoView: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            // MARK: - interface
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
                
                VStack(alignment: .center, spacing: 0) {
                    //REEl #1
                    ZStack {
                        RealView()
                        Image(symvols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        //REEl #2
                        ZStack {
                            RealView()
                            Image(symvols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        //REEl #3
                        ZStack {
                            RealView()
                            Image(symvols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    //REEl SPIN BUTTON
                    Button(action: {
                        print("spin the reels")
                    }) {
                        Image("gfx-spin")
                            .resizable()
                            .renderingMode(.original)
                            .modifier(ImageModifier())
                    }
                }//SLOT MACHINE
                .layoutPriority(2)
                
                //footer
                
                Spacer()
                
                
                HStack {
                    // bet 20
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            print("Bet 20 coins")
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifier())
                              
                        }
                        .modifier(BetCapsuleModifier())
                        
//                        .background(
//                            Capsule()
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), sta rtPoint: .top, endPoint: .bottom))
//                                .modifier(ShadowModifier())
//                        )
//                        .padding(3)
//                        .background(
//                            Capsule()
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom , endPoint: .top))
//                    )
                     Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    
                    
                    // bet 10
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            print("Bet 10 coins")
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.yellow)
                                .modifier(BetNumberModifier())
                              
                        }
                        .modifier(BetCapsuleModifier())
                        
//                        .background(
//                            Capsule()
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
//                                .modifier(ShadowModifier())
//                        )
//                        .padding(3)
//                        .background(
//                            Capsule()
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom , endPoint: .top))
//                    )
                     Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifier())
                    }
                }
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
                    self.showingInfoView = true
                }) {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .padding()
            .frame(maxWidth: 720)
            //MARK: -popup
        } // Zstack 인포뷰 눌르면 아래서 정보 인포뷰 띄우기
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
