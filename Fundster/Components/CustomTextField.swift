//
//  CustomTextField.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .renderingMode(.template)
                .foregroundColor(isFocused ? Color("Primary") : Color.gray)
            TextField(placeholder, text: $text)
                .foregroundColor(isFocused ? Color("Primary") : Color.black)
                .focused($isFocused)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(50)
        .shadow(color: Color.gray.opacity(0.20), radius: 20, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(isFocused ? Color("Primary") : Color.clear, lineWidth: 1)
        )
    }
}

