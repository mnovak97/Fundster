//
//  FundView.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import SwiftUI

struct FundView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var number: Int
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    number -= 1
                }) {
                    Image(systemName: "minus.circle")
                        .font(.largeTitle)
                        .foregroundColor(Color("Primary"))
                }
                
                TextField("Enter Number", value: $number, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 200, height: 100)
                
                Button(action: {
                    number += 1
                }) {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                        .foregroundColor(Color("Primary"))
                }
            }
            .padding()
            
            Button(action: {
                dismiss()
            }, label: {
               Text("FUND PROJECT")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 250,height: 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(20)
            })
        }
    }
}

#Preview {
    FundView(number: .constant(43))
}
