//
//  ContentView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 17/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 100
    @State private var score = 0
    
    @State private var mathQuestion: [Question] = []
    @State private var generalQuestion: [Question] = []
//    @State private var locations: [Location] = []
    
    
    var body: some View {
        
        let _ = readFile(filename: "questionList.json")
//        let _ = print(mathQuestion, generalQuestion)
//        let _ = readFile(filename: "questionBank/locations")


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
                        AnswerButton(number: choiceArray[index])
                    }
                }
            }
            
            HStack {
                ForEach(2..<4){ index in
                    Button{
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswer()
                    } label: {
                        AnswerButton(number: choiceArray[index])
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
    
//    private func readFile(filename fileName: String) {
//        print("test readFile()")
//        if let url = Bundle.main.url(forResource: "locations", withExtension: "json"),
//           let data = try? Data(contentsOf: url) {
//          let decoder = JSONDecoder()
//          if let jsonData = try? decoder.decode(JSONData.self, from: data) {
//              print(jsonData.locations)
//              self.locations = jsonData.locations
//          }
//        }
//      }
    
    func readFile(filename fileName: String) {
        print("Test readFile")
        
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: nil),
        let data = try? Data(contentsOf: url) {
          let decoder = JSONDecoder()
          if let jsonData = try? decoder.decode(JSONData.self, from: data) {
              print(jsonData.math_questions)
              self.mathQuestion = jsonData.math_questions
              self.generalQuestion = jsonData.general_questions
          }
        }
    }
}

struct JSONData: Decodable {
    let general_questions: [Question]
    let math_questions: [Question]
}

struct Question: Decodable, Identifiable {
    var id: Int
    var question: String
    var multipleChoice: [String]
    var answer: String
//}

//struct JSONData: Decodable {
//  let locations: [Location]
//}
//
//struct Location: Decodable, Identifiable {
//  let id: Int
//  let name: String
//  let latitude: Double
//  let longitude: Double
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
