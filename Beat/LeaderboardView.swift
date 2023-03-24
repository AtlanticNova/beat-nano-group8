//
//  LeaderboardView.swift
//  Beat
//
//  Created by Darvin on 23/03/23.
//

import SwiftUI
struct LeaderboardView: View{
    let players: [Player] = [
        Player(name: "John", totalPlay: 10, highScore: 100),
        Player(name: "Jane", totalPlay: 5, highScore: 200),
        Player(name: "Bob", totalPlay: 7, highScore: 150),
        Player(name: "Mary", totalPlay: 12, highScore: 80),
        Player(name: "Alex", totalPlay: 8, highScore: 120)
    ]
    
    var body: some View {
        ZStack{
            Color (red: 255/255, green: 233/255, blue: 175/255)
                .ignoresSafeArea(.all)
            
            VStack{
                HStack{
                    Button(){print("back")
                    } label: {
                        Image("back button")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Capsule()
                        .frame(maxWidth: 250, maxHeight: 50)
                        .foregroundColor(Color(red: 169/255, green: 47/255, blue: 75/255))
                        .overlay(Text("Leaderboard")
                            .foregroundColor(.white)
                            .font(.custom("1UP!", size: 20)))
                    Button(){print("re play")
                    } label: {
                        Image("return button")
                            .resizable()
                            .frame(width: 50,height: 50)
                    }

                    HStack{
                        VStack{
                            Image("Group 8")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(.top, 100)
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 169/255, green: 47/255, blue: 75/255))
                                    .padding(.trailing, -50)
                                    .padding(.bottom, -60)
                                Text("2")
                                    .font(.custom("1UP!", size: 50))
                                    .foregroundColor(.white)
                                    .padding(.bottom,100)
                            }
                        }
                        VStack{
                            Image("Group 5-2")
                                .resizable()
                                .frame(width: 150, height: 150)
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 169/255, green: 47/255, blue: 75/255))
                                    .padding(.trailing, -20)
                                    .padding(.leading, -10)
                                    .padding(.bottom, -60)
                                Text("1")
                                    .font(.custom("1UP!", size: 60))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 130)
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                        VStack{
                            Image("Group 7")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .padding(.top, 150)
                                .padding(.bottom, 10)
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 169/255, green: 47/255, blue: 75/255))
                                    .padding(.leading, -40)
                                    .padding(.bottom, -60)
                                Text("3")
                                    .font(.custom("1UP!", size: 50))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 80)
                            }
                        }
                        ZStack{
                            Color (red: 169/255, green: 47/255, blue: 75/255)
                                .ignoresSafeArea(.all)
                            RoundedRectangle(cornerRadius: 30)
                            padding()
                            VStack{
                                VStack{
                                    HStack{
                                        Text("No")
                                            .font(Font.custom("1UP!", size: 20))
                                            .fontWeight(.bold)
                                            .padding()
                                        Spacer()
                                        Text("Player")
                                            .font(Font.custom("1UP!", size: 20))
                                            .fontWeight(.bold)
                                            .padding()
                                        Spacer()
                                        Text("Score")
                                            .font(Font.custom("1UP!", size: 20))
                                            .fontWeight(.bold)
                                            .padding()
                                        ForEach(players.indices, id: \.self) { index in
                                            HStack {
                                                Spacer(minLength: 1)
                                                Text("\(index + 1)")
                                                Spacer()
                                                Text(players[index].name)
                                                Spacer()
                                                Text("\(players[index].highScore)")
                                                Spacer()
                                            }
                                            .font(Font.custom("1UP!", size:18))
                                            .foregroundColor(Color(red: 169/255, green: 47/255, blue: 75/255))
                                            .background(.white)
                                            .cornerRadius(10)
                                            .padding()
                                        }
                                    }
                                    .border(.white, width: 10)
                                    .cornerRadius(30)
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
    
    //
    ////                    .background(Color(UIColor(hex: "A92F4B")))
    //                    }
    //                }
    //                .background(Color(UIColor(hex: "FFE9AF")))
    //            Spacer()
    //    }
    //}
    
    extension UIColor {
        convenience init(hex: String) {
            var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            if hexString.hasPrefix("#") {
                hexString.remove(at: hexString.startIndex)
            }
            if hexString.count != 6 {
                self.init(red: 0, green: 0, blue: 0, alpha: 1)
            }
            var rgbValue: UInt64 = 0
            Scanner(string: hexString).scanHexInt64(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
        }
    }
    
    struct Player: Identifiable {
        let id = UUID()
        let name: String
        var totalPlay: Int
        var highScore: Int
    }

    
    struct LeaderBoardView_Preview: PreviewProvider {
        static var previews: some View {
            LeaderboardView()
        }
    }
