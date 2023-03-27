//
//  MathQuizView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 24/03/23.
//

import SwiftUI

struct MathQuizView: View {
    
    @Binding var correctAnswer: Int
    @Binding var choiceArray: [Int]
    @Binding var firstNumber: Int
    @Binding var secondNumber: Int
    @Binding var difficulty: Int
    @Binding var score: Int
    
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
//                        AnswerButton(number: choiceArray[index])
                    }
                }
            }

            HStack {
                ForEach(2..<4){ index in
                    Button{
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswer()
                    } label: {
//                        AnswerButton(number: choiceArray[index])
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
        
        for i in 0...2 {
            answerList.append(Int.random(in: 0...difficulty))
        }
        
        answerList.append(correctAnswer)
        
        choiceArray = answerList.shuffled()
    }
}

struct MathQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MathQuizView(
            correctAnswer: .constant(0),
            choiceArray: .constant([0, 1, 2, 3]),
            firstNumber: .constant(0),
            secondNumber: .constant(0),
            difficulty: .constant(100),
            score: .constant(0))
    }
}
