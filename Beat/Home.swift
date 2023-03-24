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
//                .imageScale(.small)
                .resizable()
                .frame(width: 250, height: 250)
                .foregroundColor(.accentColor)
            Text("Beat")
                .font(.custom("1UP!", size: 50))
            Spacer(minLength: 10)
            Button(){
                print("insert name")
            }   label: {
                TextField(
                    "Insert Name",
                    text: $username)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .font(Font.custom("1up", fixedSize: 20))
                    .background(Color(red: 0.66, green: 0.18, blue: 0.29))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .background{
//                        Capsule()
//                        Color(red: 0.66, green: 0.18, blue: 0.29)
//                    }
            }
            Text("Start")
                .fontWeight(.bold)
                .font(.system(size: 30))
            Text("Leaderboard")
                .fontWeight(.bold)
                .font(.system(size: 30))
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
