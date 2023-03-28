//
//  SwiftUIView.swift
//  Beat
//
//  Created by Steffi Estherianti on 21/03/23.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @State var username: String = ""
    @State var currentPage: viewPage
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Group 5-2")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .foregroundColor(.accentColor)
                Text("BEAT")
                    .font(.custom("1UP!", fixedSize: 50))
                    .foregroundColor(Color(red: 0.66, green: 0.18, blue: 0.29))
                
                TextField(
                    "INSERT NAME",
                    text: $username)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 50)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color(red: 0.66, green: 0.18, blue: 0.29))
                .accentColor(Color(red: 0.66, green: 0.18, blue: 0.29))
                .background(.white)
                .font(.custom("1UP!", size: 18))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.66, green: 0.18, blue: 0.29), lineWidth: 4)
                )
                .padding(.bottom)
                
                NavigationLink(destination: MathQuizView(correctAnswer: 0, choiceArray: [], firstNumber: 0, secondNumber: 0, answer: 0, questionLength: 0, difficulty: 0, score: 0,username: $username)) {
                    Capsule()
                        .fill(Color(red: 0.66, green: 0.18, blue: 0.29))
                        .frame(width: 300, height: 50)
                        .overlay(
                            Text("START")
                                .font(.custom("1UP!", fixedSize: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white))
                }
                .padding(.bottom)
                
                NavigationLink(destination: Leaderboard()) {
                    Capsule()
                        .fill(Color(red: 0.66, green: 0.18, blue: 0.29))
                        .frame(width: 300, height: 50)
                        .overlay(
                            Text("Leaderboard")
                                .font(.custom("1UP!", fixedSize: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white))
                }
                .padding(.bottom)
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            username: "",
            currentPage: .HomeView
        )
    }
}
