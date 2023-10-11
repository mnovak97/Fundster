//
//  LoginView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                HStack {
                    Text("Fundster")
                        .fontWeight(.bold)
                        .padding(.top, 100)
                        .font(.custom("Futura-MediumItalic", fixedSize: 50))
                        .overlay(
                            Text("ster")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Primary"))
                                .padding(.top, 100)
                                .font(.custom("Futura-MediumItalic", fixedSize: 50))
                                .offset(x: 66)
                        )
                }
                Spacer()
                VStack {
                    Text("Welcome back!")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Primary"))
                    Text("Log in to your existing Fundster account")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                
                CustomTextField(imageName: "person.circle", placeholder: "Enter email", text: $email)
                CustomTextField(imageName: "lock", placeholder: "Enter password", text: $password)
                Button {
                    
                } label: {
                    Text("LOG IN")
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
                Spacer()
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Primary"))
                    }
                }

            }
            .padding()
        }
        .accentColor(Color("Primary"))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
