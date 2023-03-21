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
    
    let haptics = UINotificationFeedbackGenerator()
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins : Int = 100
    @State private var betAmount : Int = 10
    @State private var reels: Array = [0,1,2]
    //info showing View Button 이벤트
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal : Bool = false
    @State private var animatingSymbol : Bool = false
    @State private var animationgModal : Bool = false
    
    // MARK : - FUNCTIONS
    
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count-1)
//        reels[1] = Int.random(in: 0...symbols.count-1)
//        reels[2] = Int.random(in: 0...symbols.count-1)
        
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            
            playerWins()
            // PLAYER WINS
            // NEW HIGHSCORE
            if coins > highscore {
                newHighScore()
            } else {
                playSound(sound: "win", type: "mp3")
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
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func isGameOver() {
        if coins <= 0 {
            // show modal window
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
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
                
                
                
                // MARK: -slot machine
                
                VStack(alignment: .center, spacing: 0) {
                    // MARK:- REEl #1
                    ZStack {
                        RealView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ?  1: 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration:  Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            })
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        //MARK: - REEl #2
                        ZStack {
                            RealView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ?  1: 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        
                        Spacer()
                        
                        //MARK: -REEl #3
                        ZStack {
                            RealView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ?  1: 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - REEl SPIN BUTTON
                    Button(action: {
                        
                        //1.SET DEFAULT STATE: NO ANIMAITON
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        
                        //2. 심볼이 바뀐다 릴을 돌릴때
                        self.spinReels()
                        
                        
                        //3. 트리거 애니메이션 후 심볼이 바뀐다
                        withAnimation{
                            self.animatingSymbol = true
                        }
                        
                        //4.Chck winning
                        self.checkWinning()
                        
                        //5. GAME IS OVER
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
                    //MARK: - bet 20
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
                     
                     Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    
                    Spacer()
                    
                    // MARK: -bet 10
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
         
                     Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
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
                                self.animationgModal = false
                                self.activateBet10()
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
                    .opacity($animationgModal.wrappedValue ? 1 : 0)
                    .offset(y: $animationgModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                    .onAppear(perform: {
                        self.animationgModal = true
                    })
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
