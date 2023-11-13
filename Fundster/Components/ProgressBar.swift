//
//  ProgressBar.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct ProgressBar: View {
    @State private var progress: CGFloat = 0.0
    let moneyAcquired: Int
    let moneyGoal: Int
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                           Rectangle()
                               .frame(width:geometry.size.width, height: 5)
                               .opacity(0.3)
                               .foregroundColor(.gray)
                           
                           Rectangle()
                               .frame(width: calculateProgressWidth(in: geometry.size.width), height: 5)
                               .foregroundColor(Color("Primary"))
                               .animation(.linear(duration: 1.0) , value: progress)
                       }
                .cornerRadius(5)
            }
            .frame(height: 10)
            .onAppear {
                updatePercentage(moneyAcquired: moneyAcquired, moneyGoal: moneyGoal)
            }
        }
    }
    private func calculateProgressWidth(in totalWidth: CGFloat) -> CGFloat {
        return totalWidth * progress
    }

    private func updatePercentage(moneyAcquired: Int, moneyGoal: Int) {
        guard moneyGoal > 0 else { return }
        progress = CGFloat(moneyAcquired) / CGFloat(moneyGoal)
    }
}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(moneyAcquired: 12345, moneyGoal: 12345)
    }
}
