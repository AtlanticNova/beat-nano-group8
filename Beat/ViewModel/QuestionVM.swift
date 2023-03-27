//
//  GameManagerVM.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 25/03/23.
//

import Foundation
import SwiftUI

class QuestionVM : ObservableObject {
    static var currentIndex = 0
    
    static func createGameModel(i:Int) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = QuestionVM.createGameModel(i: QuestionVM.currentIndex)
    
    var timer = Timer()
    var maxProgress = 60
    @Published var progress = 0
    
    init() {
        self.start()
    }
    
    func verifyAnswer(selectedOption: QuizOption){
        for index in model.quizModel.optionList.indices {
            model.quizModel.optionList[index].isMatched = false
            model.quizModel.optionList[index].isSelected = false
        }
        
        if let index = model.quizModel.optionList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId == model.quizModel.answer {
                model.quizModel.optionList[index].isMatched = true
                model.quizModel.optionList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (QuestionVM.currentIndex < 2){
                        QuestionVM.currentIndex = QuestionVM.currentIndex + 1
                        self.model = QuestionVM.createGameModel(i: QuestionVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        self.reset()
                    }
                }
            } else {
                model.quizModel.optionList[index].isMatched = false
                model.quizModel.optionList[index].isSelected = true
            }
        }
    }
    
    func restartGame() {
        QuestionVM.currentIndex = 0
        model = QuestionVM.createGameModel(i: QuestionVM.currentIndex)
        self.start()
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { time in
            if self.progress == self.maxProgress{
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        })
    }
    
    func reset() {
        timer.invalidate()
        self.progress = 0
    }
}

extension QuestionVM {
    static var quizData: [QuizModel] {
        [
            QuizModel(
                question: "1 + 1 = ...",
                answer: "B",
                optionList: [
                    QuizOption(id: 1, optionId: "A", option: "1", color: Color.red),
                    QuizOption(id: 2, optionId: "B", option: "2", color: Color.yellow),
                    QuizOption(id: 3, optionId: "C", option: "3", color: Color.green),
                    QuizOption(id: 4, optionId: "D", option: "4", color: Color.blue)
                ]
            ),
            
            QuizModel(
                question: "Kapan tanggal kemerdekaan Indonesia",
                answer: "D",
                optionList: [
                    QuizOption(id: 5, optionId: "A", option: "1", color: Color.red),
                    QuizOption(id: 6, optionId: "B", option: "2", color: Color.yellow),
                    QuizOption(id: 7, optionId: "C", option: "3", color: Color.green),
                    QuizOption(id: 8, optionId: "D", option: "4", color: Color.blue)
                ])
        ]
    }
}
