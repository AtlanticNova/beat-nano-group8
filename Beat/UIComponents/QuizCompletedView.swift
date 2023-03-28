//
//  QuizCompletedVIew.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 27/03/23.
//

import Foundation
import SwiftUI

struct QuizCompletedView: View {
    var questionVM: QuestionVM
    
    var body: some View {
        VStack {
            Image(systemName: "gameController.fill")
                .foregroundColor(Color.yellow)
                .font(.system(size: 60))
                .padding()
            
            ReusableText(text: questionVM.model.quizWinningStatus ? "YOU BEAT THE QUIZ" : "GAME OVER", size: 30)
                .padding()
            
            ReusableText(text: questionVM.model.quizWinningStatus ? "Thank you for playing!!" : "Better luck next time", size: 30)
                .padding()
            
            Button {
                questionVM.restartGame()
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.custom("1UP!", size: 24))
                        .padding()
                    
                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.custom("1UP!", size: 24))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }
            .frame(width: 300, height: 60, alignment: .center)
            .background(.purple.opacity(0.7))
            .cornerRadius(30)
        }
    }
}
