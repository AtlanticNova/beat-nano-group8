//
//  AnswerButton.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 23/03/23.
//

import Foundation
import SwiftUI

struct OptionGridView: View {
    var questionVM: QuestionVM
    var columns : [GridItem] = Array(repeating: GridItem(.fixed(170), spacing: 0), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(QuestionVM.quizData[0].optionList) { quizOption in
                OptionCardView(quizOption: quizOption)
                    .onTapGesture {
                        questionVM.verifyAnswer(selectedOption: quizOption)
                    }
            }
        }
    }
}

struct OptionCardView: View {
    var quizOption: QuizOption
    
    var body: some View {
        VStack{
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: "checkmark")
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: "xmark")
            } else {
                OptionView(quizOption: quizOption)
            }
        }
        .frame(width: 150, height: 150)
        .background(setBackgroundColor())
        .cornerRadius(20)
    }
    
    func setBackgroundColor() -> Color {
        if (quizOption.isMatched) && (quizOption.isSelected){
            return Color.green
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return Color.red
        } else {
            return Color.white
        }
    }
}

struct OptionStatusImageView: View {
    var imageName: String
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .foregroundColor(Color.white)
    }

}

struct OptionView: View {
    var quizOption: QuizOption
    
    var body: some View {
        VStack {
            Text(quizOption.optionId)
                .font(.custom("1UP!", size: 30))
                .bold()
                .frame(width: 50, height: 50)
                .background(quizOption.color.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(25)
            
            Text(quizOption.option)
                .frame(width: 150, height: 30)
                .font(.system(size: 20, weight: .bold, design: .rounded))
        }
    }
}
