//
//  TriviaQuizView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 25/03/23.
//

import SwiftUI

struct TriviaQuizView: View {
    @ObservedObject var questionVM: QuestionVM
    
    var body: some View {
        if (questionVM.model.quizCompleted) {
            QuizCompletedView(questionVM: questionVM)
        } else {
            VStack{
                ReusableText(text: "BEAT QUIZ !!!", size: 30)
                    .padding()
                
                ReusableText(text: questionVM.model.quizModel.question, size: 20)
                    .lineLimit(3)
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 60, alignment: .center)
                    .multilineTextAlignment(.center)
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15 )
                        .foregroundColor(.gray)
                        .opacity(0.3)
                    
                    Circle()
                        .trim(from: 0.0, to: min(CGFloat(questionVM.progress), 1.0))
                        .stroke(LinearGradient( colors: [Color(red: 0.66, green: 0.18, blue: 0.29), .white],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 270))
                        .animation(Animation.linear(
                            duration: Double(questionVM.maxProgress)), value: questionVM.progress)
                    
                    ReusableText(text: String(questionVM.progress), size: 30)
                }
                .frame(width: 150, height: 150)
                
                Spacer()
                
                OptionGridView(questionVM: questionVM)
            }
        }
    }
}

struct TriviaQuizView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuizView(questionVM: QuestionVM())
    }
}
