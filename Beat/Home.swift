//
//  SwiftUIView.swift
//  Beat
//
//  Created by Steffi Estherianti on 21/03/23.
//

import SwiftUI

struct Home: View {
    @State private var username:String = ""
    var body: some View {

        VStack {
            Spacer()
            Image("Group 5-2")
                .resizable()
                .frame(width: 250, height: 250)
                .foregroundColor(.accentColor)
            Text("Beat")
                .font(.custom("1UP!", fixedSize: 50))
                .foregroundColor(Color(red: 0.66, green: 0.18, blue: 0.29))
            
            Button(){
                print("insert name")
            }   label: {
                Capsule()
                    .fill(Color(red: 0.66, green: 0.18, blue: 0.29))
                    .frame(width: 300, height: 50)
                    .overlay(
                TextField(
                    "INSERTNAME",
                    text: $username)
                .foregroundColor(.white))
                .font(.custom("1UP!", fixedSize: 18))
                .fontWeight(.bold)
            }
            Button(){
                print("start game")
            } label: {
                Capsule()
                    .fill(Color(red: 0.66, green: 0.18, blue: 0.29))
                    .frame(width: 300, height: 50)
                    .overlay(
                        Text("START")
                                .font(.custom("1UP!", fixedSize: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white))
            }
            Button(){
                print("Leaderboard")
            } label: {
                Capsule()
                    .fill(Color(red: 0.66, green: 0.18, blue: 0.29))
                    .shadow(color: .gray, radius: 10, x: 0, y: 10)
//                    .opacity(80)
                    .frame(width: 300 ,height: 50)
                    .overlay(
                        Text("LEADERBOARD")
                                .font(.custom("1UP!", fixedSize: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white))
            }
            Spacer()
        }
        .background(Color(red: 255/255, green: 233/255, blue: 175/255))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
