//
//  LeaderboardView.swift
//  Beat
//
//  Created by Darvin on 23/03/23.
//

import SwiftUI
import FirebaseFirestore

struct LeaderboardView: View {
    @State var players: [Player] = [
//        Player(name: "John", totalPlay: 10, highScore: 100),
//        Player(name: "Jane", totalPlay: 5, highScore: 200),
//        Player(name: "Bob", totalPlay: 7, highScore: 150),
//        Player(name: "Mary", totalPlay: 12, highScore: 80),
//        Player(name: "Alex", totalPlay: 8, highScore: 120)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Capsule()
                    .frame(maxWidth: 250, maxHeight: 50)
                    .foregroundColor(.yellow)
                    .overlay(Text("Leaderboard")
                        .foregroundColor(.white)
                        .font(.custom("1UP!", size: 30))
                    )
            }
            
            
            VStack{
                VStack{
                    HStack {
                        Text("No")
                            .font(Font.custom("1up", size: 15))
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                        Text("Player")
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                        Text("Score")
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    ForEach(players.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                            Spacer()
                            Text(players[index].name)
                            Spacer()
                            Text("\(players[index].score)")
                        }
                        .background(.red)
                        .cornerRadius(20)
                        .padding(5)
                    }
                }.border(.black, width: 5)
                    .cornerRadius(10)
                    .padding(10)
            }
            .background(Color(UIColor(hex: "A92F4B")))

        }
        .background(Color(UIColor(hex: "FFE9AF")))
        .onAppear{
            fetchLeaderboardData()
//            insertLeaderboardData()
            
            let _ = print(players)
        }
    }
    
    func fetchLeaderboardData() {
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
                            
//                            let newItem = Item(id: id, name: name)
                            let newItem = Player(id: id, name: name, score: score)
                            self.players.append(newItem)
                        }
                    }
        }
    }
}

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
    var id: String
    var name: String
    var score: Int
}


struct LeaderBoardView_Preview: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
