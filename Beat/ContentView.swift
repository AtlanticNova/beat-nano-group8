//
//  ContentView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 17/03/23.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 100
    @State private var score = 0
    
    @State var mathQuestion: [Question] = []
    @State var generalQuestion: [Question] = []
    @State var pictureQuestion: [Question] = []
    @State var jsonData: JSONData = JSONData(general_questions: [], math_questions: [], picture_questions: [])
//    @State private var locations: [Location] = []
    
    
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
            
        }
        .onAppear{
            self.generateAnswer()
            self.readFile(filename: "questionList")
            let _ = print(self.generalQuestion, self.pictureQuestion, self.mathQuestion)
        }
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
    
    func readFile(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(JSONData.self, from: data)
                self.generalQuestion = decodedData.general_questions
                self.mathQuestion = decodedData.math_questions
                self.pictureQuestion =
                decodedData.picture_questions
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
            "name": "darvin",
            "score": 1100,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
