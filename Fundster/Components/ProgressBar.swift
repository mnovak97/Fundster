//
//  ProgressBar.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct ProgressBar: View {
    @State private var progress: CGFloat = 0.0
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                           Rectangle()
                               .frame(width:geometry.size.width, height: 5)
                               .opacity(0.3)
                               .foregroundColor(.gray)
                           
                           Rectangle()
                               .frame(width: geometry.size.width * progress, height: 5)
                               .foregroundColor(Color("Primary"))
                               .animation(.linear(duration: 1.0) , value: progress)
                       }
                .cornerRadius(5)
            }
            .frame(height: 10)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
