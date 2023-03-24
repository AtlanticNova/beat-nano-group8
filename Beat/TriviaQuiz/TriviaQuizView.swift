//
//  TriviaQuizView.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 25/03/23.
//

import SwiftUI

struct TriviaQuizView: View {
    var body: some View {
        VStack {
            ReusableText(text: "BEAT QUIZ !!!", size: 30)
                .padding()
            
            ReusableText(text: "MY QUESTION", size: 30)                .lineLimit(3)
                .frame(width: UIScreen.main.bounds.size.width - 20, height: 60, alignment: .center)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

struct TriviaQuizView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuizView()
    }
}
