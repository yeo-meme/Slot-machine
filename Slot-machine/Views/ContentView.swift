//
//  ContentView.swift
//  Slot-machine
//
//  Created by yeomim Kim on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    let symbols = ["gfx-bell","gfx-cherry","gfx-coin",
    "gfx-grape","gfx-seven","gfx-strawberry"]
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins : Int = 100
    @State private var betAmount : Int = 10
    @State private var reels: Array = [0,1,2]
    //info showing View Button 이벤트
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal : Bool = false
    
    // MARK : - FUNCTIONS
    
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count-1)
//        reels[1] = Int.random(in: 0...symbols.count-1)
//        reels[2] = Int.random(in: 0...symbols.count-1)
        
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            
            playerWins()
            // PLAYER WINS
            // NEW HIGHSCORE
            if coins > highscore {
                newHighScore()
            }
        } else {
            // PLAYER LOSES
            playerLoses()
        }
    }
    
    func playerWins() {
        coins += betAmount * 10
    }
    
    //최고점 갱신
    func newHighScore() {
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: "HighScore")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    func isGameOver() {
        if coins <= 0 {
            // show modal window
            showingModal = true
        }
    }
    
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()  
    }
    // SPIN THE REELS
    // CEHCK THE WINNING
    // PLAYER WINS
    // NEW HIGHSCORE
    // PLAYER LOSES
    // GAME IS OVER
    
    
     
    
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
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    
                    HStack{
                        Text("\(highscore)")
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
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        //REEl #2
                        ZStack {
                            RealView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        //REEl #3
                        ZStack {
                            RealView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - REEl SPIN BUTTON
                    Button(action: {
                        self.spinReels()
                        
                        //Chck winning
                        self.checkWinning()
                        
                        // GAME IS OVER
                        self.isGameOver()
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
                    //MARK : - bet 20
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            self.activateBet20()
                            print("Bet 20 coins")
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
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
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    
                    
                    // MARK : -bet 10
                    HStack(alignment: .center, spacing: 10) {
                        Button(action: {
                            print("Bet 10 coins")
                            self.activateBet10()
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : Color.white)
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
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                }
            }
            // MARK: - buttons
            .overlay(
                Button(action: {
                    self.resetGame()
                    print("Reset the game")
                }){
                    Image(systemName: "arrow.2.circlepath.circle")
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
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            //MARK: -popup
            if $showingModal.wrappedValue{
                ZStack{
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    
                    
                    //MOADL
                    VStack(spacing: 0) {
                        //  TITLE
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        //MESSAGE
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! You loast all of th coins. \nLet's play again")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            
                            
                            Button(action: {
                                self.showingModal = false
                                self.coins = 100
                            }) {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75)
                                        .foregroundColor(Color("ColorPink"))
                                     )
                            }
                        }
                        
                        Spacer()
                    }
                    
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x:0, y: 8)
                }
            }
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
