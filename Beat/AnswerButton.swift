//
//  AnswerButton.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 23/03/23.
//

import SwiftUI

struct AnswerButton: View {
    var number : Int
    
    var body: some View {
        Text("\(number)")
            .frame(width: 110, height: 110)
            .font(.custom("1UP!", size: 36))
//            .font(.system(size: 40, weight: .bold
//                         ))
            .foregroundColor(Color.white)
            .background(Color(red: 0.66, green: 0.16, blue: 0.29))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(number: 100)
    }
}
