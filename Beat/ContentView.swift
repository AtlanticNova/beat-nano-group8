//
//  ContentView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 17/03/23.
//

import SwiftUI
import FirebaseFirestore

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

    @State var mathQuestion: [Question] = []
    @State var generalQuestion: [Question] = []
    @State var pictureQuestion: [Question] = []
    @State var jsonData: JSONData = JSONData(general_questions: [], math_questions: [], picture_questions: [])
    
    var body: some View {
        ZStack{
            Color(red: 1.0, green: 0.91, blue: 0.77)
                .ignoresSafeArea(.all)
            if currentPage == .HomeView {
                HomeView(
                    username: userName,
                    currentPage: currentPage
                )
            } else if currentPage == .MathQuizView {
//                MathQuizView(
//                    correctAnswer: $correctAnswer,
//                    choiceArray: $choiceArray,
//                    firstNumber: $firstNumber,
//                    secondNumber: $secondNumber,
//                    difficulty: $difficulty,
//                    score: $score
//                )
            }
        }.onAppear{
                    self.readFile(filename: "questionList")
                    let _ = print(self.generalQuestion, self.pictureQuestion, self.mathQuestion)
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
