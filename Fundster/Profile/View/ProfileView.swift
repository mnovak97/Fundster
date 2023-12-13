//
//  ProfileView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var authVM : AuthViewModel
    @ObservedObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            ZStack {
                AsyncImage(
                    url: URL(string: viewModel.user?.profilePictureUrl ?? ""),
                    content: { image in
                        image
                            .resizable()
                            .frame(height: 150)
                            .clipShape(Circle())
                            .scaledToFit()
                    },
                    placeholder: {
                         Image("profile")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                )
                NavigationLink {
                    ProfilePictureUpdateView()
                } label: {
                    Image(systemName: "plus.square.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color("Primary"))
                }.offset(x: 50, y: 65)

            }
            .padding(.bottom , 50)
            VStack (alignment:.leading, spacing: 5) {
                HStack {
                    Text("Name:")
                    Text(viewModel.user?.name ?? "")
                }
            }
            Divider()
                .padding(.leading, 50)
                .padding(.trailing, 50)
            VStack (alignment:.leading, spacing: 5) {
                HStack {
                    Text("Phone number:")
                    Text(viewModel.user?.phoneNumber ?? "")
                }
            }
            Divider()
                .padding(.leading, 50)
                .padding(.trailing, 50)
            VStack (alignment:.leading, spacing: 5) {
                HStack {
                    Text("Email:")
                    Text(viewModel.user?.email ?? "")
                }
            }
            Divider()
                .padding(.leading, 50)
                .padding(.trailing, 50)
            Button {
                authVM.logout()
            } label: {
                Text("Log out")
                    .padding()
                    .bold()
                    .frame(height: 30)
                    .background(Color("Primary"))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()

        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthViewModel())
    }
}
