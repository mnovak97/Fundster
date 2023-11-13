//
//  CustomFavouriteButton.swift
//  Fundster
//
//  Created by Martin Novak on 19.10.2023..
//

import SwiftUI

struct CustomFavouriteButton: View {
    @State private var isLiked = false
    var body: some View {
        Button {
            withAnimation(Animation.easeOut(duration: 0.5)) {
                isLiked.toggle()
            }
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(.system(size: 35))
                .frame(width: 40,height: 30)
                .foregroundColor(.black)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
        }

    }
}

struct CustomFavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomFavouriteButton()
    }
}
