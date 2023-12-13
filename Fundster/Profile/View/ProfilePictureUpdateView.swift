//
//  ProfilePictureUpdateView.swift
//  Fundster
//
//  Created by Martin Novak on 14.11.2023..
//

import SwiftUI
import PhotosUI

struct ProfilePictureUpdateView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @State private var profilePictureItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var profileUIImgae: UIImage?
    var body: some View {
        VStack(spacing: 30) {
            PhotosPicker(selection: $profilePictureItem, matching: .images) {
                if let profileImage {
                    profileImage
                        .resizable()
                        .frame(height: 150)
                        .clipShape(Circle())
                        .scaledToFit()
                    
                    
                } else {
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
                }
            }
            Button {
                if let image = profileUIImgae {
                    viewModel.uploadUserProfilePicture(image)
                }
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Update profile picture")
                    .padding()
                    .bold()
                    .frame(height: 30)
                    .background(Color("Primary"))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }
        .onChange(of: profilePictureItem) { _ in
            Task {
                if let data = try? await profilePictureItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        profileUIImgae = uiImage
                        profileImage = Image(uiImage: uiImage)
                        return
                    }
                }
                print("Failed")
            }
        }
    }
}

#Preview {
    ProfilePictureUpdateView()
}
