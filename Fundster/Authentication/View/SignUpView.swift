//
//  SignUpView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var phone: String = ""
    var body: some View {
        VStack (spacing: 30) {
            VStack {
                Text("Let's Get Started!")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .foregroundColor(Color("Primary"))
                Text("Create your account for Fundster")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            
            CustomTextField(imageName: "person.circle", placeholder: "Name", text: $name)
            CustomTextField(imageName: "envelope", placeholder: "Email", text: $email)
            CustomTextField(imageName: "iphone", placeholder: "Phone", text: $phone)
            CustomTextField(imageName: "lock", placeholder: "Password", text: $password)
            Button {
                
            } label: {
                Text("SIGN UP")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                    .padding(.horizontal, 20)
            }
            
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
