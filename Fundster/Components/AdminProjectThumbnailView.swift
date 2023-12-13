//
//  AdminProjectThumbnailView.swift
//  Fundster
//
//  Created by Martin Novak on 14.11.2023..
//

import SwiftUI

struct AdminProjectThumbnailView: View {
    @State var project : Project
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(
                url: URL(string: project.projectPictureUrl ?? ""),
                content: { image in
                    image
                        .resizable()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                },
                placeholder: {
                     Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            )
            VStack {
                HStack {
                    Text("Project name:")
                    Text(project.name ?? "")
                        .bold()
                }
            }
        }
    }
}

#Preview {
    AdminProjectThumbnailView(project: Project(id: 205, name: "Asdasd", projectPictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/fundster-f5983.appspot.com/o/projectImages%2FB293AD92-8254-47D0-9664-585B3B127D6E?alt=media&token=1530e9f6-850e-45a4-988e-f83884dba5e4", description: "Description", moneyGoal: 12341, moneyAcquired: 0, backers: 0, deadline: Date(), userID: 1))
}
