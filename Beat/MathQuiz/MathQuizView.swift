//
//  MathQuizView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 24/03/23.
//

import SwiftUI

struct MathQuizView: View {
    
    @State var correctAnswer: Int
    @State var choiceArray: [Int]
    @State var firstNumber: Int
    @State var secondNumber: Int
    @State var difficulty: Int
    @State var score: Int
    
    @Binding var username: String
    
    var body: some View {
        VStack {
           Text("\(firstNumber) + \(secondNumber) = ...")
                .font(.custom("1UP!", size: 42))
                .bold()
                .foregroundColor(Color(red: 0.66, green: 0.16, blue: 0.26))
            
            HStack {
                ForEach(0..<2){ index in
                    Button{
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswer()
                    } label: {
                        if !choiceArray.isEmpty {
                            AnswerButton(number: choiceArray[index])
                        }
                    }
                }
            }

            HStack {
                ForEach(2..<4){ index in
                    Button{
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswer()
                    } label: {
                        if !choiceArray.isEmpty {
                            AnswerButton(number: choiceArray[index])
                        }
                    }
                }
            }
            
            Text("SCORE: \(score)")
                .font(.custom("1UP!", size: 42))
                .bold()
                .foregroundColor(Color(red: 0.66, green: 0.16, blue: 0.26))
            
        }.onAppear(perform: generateAnswer)
        .padding()
    }
    
    func answerIsCorrect(answer: Int) {
        let isCorrect = answer == correctAnswer ? true : false
        
        if isCorrect {
            self.score += 1
        } else {
            self.score += 0
        }
    }
    
    func generateAnswer() {
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        
        correctAnswer = firstNumber + secondNumber
        
        for _ in 0...2 {
            answerList.append(Int.random(in: 0...difficulty))
        }
        
        answerList.append(correctAnswer)
        
        choiceArray = answerList.shuffled()
    }
}

struct MathQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MathQuizView(
            correctAnswer: 0,
            choiceArray: [0,1,2,3],
            firstNumber: 0,
            secondNumber: 0,
            difficulty: 100,
            score: 0,
            username: .constant("John"))
    }
}
