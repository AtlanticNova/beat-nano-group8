//
//  MathQuizView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 24/03/23.
//

import SwiftUI
import FirebaseFirestore

struct MathQuizView: View {
    
    @State var correctAnswer: Int
    @State var choiceArray: [Int]
    @State var firstNumber: Int
    @State var secondNumber: Int
    
    @State var question: String = ""
    @State var multipleChoice: [String] = []
    @State var answer: Int
    @State var questionIndex: Int = 0
    @State var questionLength: Int
    
    @State var difficulty: Int
    @State var score: Int
    
    @Binding var username: String
    
    @State var mathQuestion: [Question] = []
    @State var generalQuestion: [Question] = []
    @State var pictureQuestion: [Question] = []
    @State var jsonData: JSONData = JSONData(general_questions: [], math_questions: [], picture_questions: [])
    
    var body: some View {
        VStack {
//           Text("\(firstNumber) + \(secondNumber) = ...")
            Text("\(self.question)")
                .font(.custom("1UP!", size: 30))
                .bold()
                .foregroundColor(Color(red: 0.66, green: 0.16, blue: 0.26))
            
            HStack {
                ForEach(0..<2){ index in
                    Button{
                        answerIsCorrect(answer: Int(multipleChoice[index]) ?? 0)
//                        generateAnswer()
                        nextQuestion()
                    } label: {
                        if !multipleChoice.isEmpty {
                            AnswerButton(number: Int(multipleChoice[index]) ?? 0)
                        }
                    }
                }
            }

            HStack {
                ForEach(2..<4){ index in
                    Button{
                        answerIsCorrect(answer: Int(multipleChoice[index]) ?? 0)
                        nextQuestion()
//                        generateAnswer()
                    } label: {
                        if !multipleChoice.isEmpty {
                            AnswerButton(number: Int(multipleChoice[index]) ?? 0)
                        }
                    }
                }
            }
            
            Text("SCORE: \(score)")
                .font(.custom("1UP!", size: 42))
                .bold()
                .foregroundColor(Color(red: 0.66, green: 0.16, blue: 0.26))
            
        }.onAppear{
            generateAnswer()
            readFile(filename: "questionList")
        }
        .padding()
    }
    
    func answerIsCorrect(answer: Int) {
        let _ = print(answer, correctAnswer)
        let isCorrect = answer == self.answer ? true : false
        let _ = print(isCorrect)
        
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
    
    func nextQuestion(){
        if (questionIndex < (questionLength - 1)) {
            questionIndex = questionIndex + 1
            self.question = mathQuestion[questionIndex].question
            self.multipleChoice = mathQuestion[questionIndex].multipleChoice
            self.answer = Int(mathQuestion[questionIndex].answer) ?? 0
        } else {
            insertLeaderboardData()
            self.question = "You Have Finished the Quiz !"
            self.multipleChoice = ["", "", "", ""]
        }
    }
    
    func readFile(filename fileName: String) {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
                do{
                    let data = try Data(contentsOf: url)
                    let decodedData = try JSONDecoder().decode(JSONData.self, from: data)
                    self.generalQuestion = decodedData.general_questions
                    self.mathQuestion = decodedData.math_questions
                    self.pictureQuestion =
                            decodedData.picture_questions
//                    let _ = print(decodedData.math_questions)
//                    let _ = print(self.mathQuestion)
//                    let _ = print(mathQuestion[0].question)
                    self.question = mathQuestion[0].question
                    self.multipleChoice = mathQuestion[0].multipleChoice
                    self.answer = Int(mathQuestion[0].answer) ?? 0
                    self.questionLength = mathQuestion.count
                } catch {
                    print("Error decoding JOSN: \(error)")
                }
            } else {
                print("error loading \(fileName) json file")
            }
        }
    
    func insertLeaderboardData() {
            let db = Firestore.firestore()

            var ref: DocumentReference? = nil
            ref = db.collection("leaderboard").addDocument(data: [
                "name": username,
                "score": score,
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
}

struct MathQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MathQuizView(
            correctAnswer: 0,
            choiceArray: [0,1,2,3],
            firstNumber: 0,
            secondNumber: 0,
            answer: 0, questionLength: 0, difficulty: 100,
            score: 0,
            username: .constant("John"))
    }
}

struct JSONData: Decodable {
    let general_questions: [Question]
    let math_questions: [Question]
    let picture_questions: [Question]
}

struct Question: Decodable, Identifiable {
    var id: Int
    var question: String
    var multipleChoice: [String]
    var answer: String
}

struct picQuestion: Decodable, Identifiable {
    var id: Int
    var asset: String
    var question: String
    var multipleChoice: [String]
    var answer: String
}
