//
//  ProfileThumbnailView.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import SwiftUI

struct ProfileThumbnailView: View {
    @State var user: User
    var body: some View {
        HStack {
            Text(user.name ?? "")
        }
    }
}

#Preview {
    ProfileThumbnailView(user: User(id: 252, name: "Marko", email: "marko@mail.com", role: Role.USER, profilePictureUrl: "", phoneNumber: "", password: "", projects: [Project](), favouriteProjects: [Project]()))
}
