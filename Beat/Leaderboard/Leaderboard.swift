//
//  Leaderboard.swift
//  Beat
//
//  Created by Steffi Estherianti on 26/03/23.
//

import SwiftUI
import FirebaseFirestore

struct Leaderboard: View {
    
    @State var players: [Player] = []
    
    var body: some View {
        
        ZStack{
            Color(red: 255/255, green: 233/255, blue: 175/255)
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
                        .overlay(Text("Leaderboard"))
                        .foregroundColor(.white)
                        .font(.custom("1UP!", size: 20))
                    Button(){print("re play")
                    } label: {
                        Image("return button")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                Spacer()
                
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
                            VStack{
                                Text("2")
                                    .font(.custom("1UP!", size: 50))
                                    .foregroundColor(.white)
                                    .padding()
                                if !players.isEmpty {
                                    Text("\(players[1].name)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                    Text("\(players[1].score)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                } else {
                                    Text("Winner")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                        }
                    }
                    VStack{
                        Image("Group 5-2")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding(.top)
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red: 169/255, green: 47/255, blue: 75/255))
                                .padding(.trailing, -20)
                                .padding(.leading, -10)
                                .padding(.bottom, -60)
                            VStack{
                                Text("1")
                                    .font(.custom("1UP!", size: 50))
                                    .foregroundColor(.white)
                                    .padding()
                                if !players.isEmpty{
                                    Text("\(players[0].name)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                    Text("\(players[0].score)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                } else {
                                    Text("Winner")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                        }
                    }
                    VStack{
                        Image("Group 7")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .padding(.top, 150)
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red: 169/255, green: 47/255, blue: 75/255))
                                .padding(.leading, -40)
                                .padding(.bottom, -60)
                            VStack{
                                Text("3")
                                    .font(.custom("1UP!", size: 50))
                                    .foregroundColor(.white)
                                    .padding()
                                if !players.isEmpty {
                                    Text("\(players[2].name)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                    Text("\(players[2].score)")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                } else {
                                    Text("Winner")
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                }.onAppear{
                    fetchLeaderboardData()
                    let _ = print(self.players)
                }
                
                
                ZStack {
                    Color(red: 169/255, green: 49/255, blue: 75/255)
                        .ignoresSafeArea(.all)
                    
                    VStack{
                        VStack{
                            HStack{
                                Text("No")
                                    .font(Font.custom("1UP!", size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                Spacer()
                                Text("Player")
                                    .font(Font.custom("1UP!", size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                Spacer()
                                Text("Score")
                                    .font(Font.custom("1UP!", size: 20))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                }
                            
                                VStack{
                                    ForEach(players.indices, id: \.self) {index in
                                        HStack {
                                            Spacer(minLength: 1)
                                            Text("\(index + 1)")
                                            Spacer()
                                            Text(players[index].name)
                                            Spacer()
                                            Text("\(players[index].score)")
                                            Spacer()
                                        }
                                        .font(.custom("1UP!", size: 15))
                                        .foregroundColor(.white)
                                        .padding(5)
                                    }
                                }
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 5)
                                .padding())
                    }
                    
                }
                    
                    
                    
                }
                
        }.onAppear{
//            fetchLeaderboardData()
        }
        }
    
    func fetchLeaderboardData() {
        self.players = []
        let db = Firestore.firestore()

        db.collection("leaderboard").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let score = data["score"] as? Int ?? 0

                    let newItem = Player(id: id, name: name, score: score)
                    self.players.append(newItem)
                }
                self.players = self.players.sorted(by: {$0.score > $1.score})
            }
        }
        
    }
    }


extension UIColor{
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
        var rgbValue: UInt64 = 0
        Scanner(string:hexString).scanHexInt64(&rgbValue)
        self.init(red:CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green:CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue:CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}

struct Player: Identifiable {
    var id: String
    var name: String
    var score: Int
}
    
struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
    Leaderboard()
    }
}

