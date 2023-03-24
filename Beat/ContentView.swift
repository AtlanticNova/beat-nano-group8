//
//  ContentView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 17/03/23.
//

import SwiftUI

enum viewPage {
    case HomeView
    case MathQuizView
}

struct ContentView: View {
    @State var currentPage: viewPage = .HomeView
    @State var userName: String = ""
    @State var correctAnswer = 0
    @State var choiceArray : [Int] = [0, 1, 2, 3]
    @State var firstNumber = 0
    @State var secondNumber = 0
    @State var difficulty = 100
    @State var score = 0
    
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 179/255, blue: 175/255)
                .ignoresSafeArea(.all)
            if currentPage == .HomeView {
                HomeView(
                    username: $userName
//                    currentPage: $currentPage
                )
            } else if currentPage == .MathQuizView {
                MathQuizView(
                    correctAnswer: $correctAnswer,
                    choiceArray: $choiceArray,
                    firstNumber: $firstNumber,
                    secondNumber: $secondNumber,
                    difficulty: $difficulty,
                    score: $score
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
