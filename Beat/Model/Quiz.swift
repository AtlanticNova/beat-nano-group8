//
//  QuizModel.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 25/03/23.
//

import Foundation
import SwiftUI

struct Quiz {
    var currentQuestionIndex: Int
    var quizModel: QuizModel
    var quizCompleted: Bool = false
    var quizWinningStatus: Bool = false
}

struct QuizModel {
    var question: String
    var answer: String
    var optionList: [QuizOption]
}

struct QuizOption : Identifiable {
    var id: Int
    var optionId: String
    var option: String
    var color: Color
    var isSelected: Bool = false
    var isMatched: Bool = false
}
