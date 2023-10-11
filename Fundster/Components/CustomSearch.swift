//
//  CustomSearch.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct CustomSearch: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: isFocused ? "magnifyingglass" : "")
                    .foregroundColor(.black)
                    .padding(.leading, 16)
                    .animation(.spring(), value: isFocused)
                TextField(isFocused ? "Search" : "", text: $text)
                    .padding(8)
                    .frame(height: 70)
                    .animation(.easeIn, value: isFocused)
                    .focused($isFocused)
            }
            HStack {
                Image(systemName: isFocused ? "" : "magnifyingglass")
                    .foregroundColor(.black)
                    .padding(.leading, 16)
                
                Text(isFocused ? "" : "Search")
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .onTapGesture {
            isFocused = true
        }
        
    }
}

struct CustomSearch_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearch(text: .constant(""))
    }
}
