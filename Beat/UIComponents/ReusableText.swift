//
//  ReusableText.swift
//  Beat
//
//  Created by Martinus Andika Novanawa on 25/03/23.
//

import Foundation
import SwiftUI

struct ReusableText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.custom("1UP!", size: size))
            .foregroundColor(Color(red: 0.66, green: 0.16, blue: 0.29))
            .shadow(color: .white, radius: 2, x: 0, y: 3)
    }
}
