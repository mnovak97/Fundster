//
//  ProjectCard.swift
//  Fundster
//
//  Created by Martin Novak on 01.11.2023..
//

import SwiftUI

struct ProjectCard: View {
    @State var project: Project
    var body: some View {
        VStack (spacing: 10) {
            AsyncImage(
                url: URL(string: project.projectPictureUrl ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Tsunami_by_hokusai_19th_century.jpg/700px-Tsunami_by_hokusai_19th_century.jpg"),
                    content: { image in
                        image
                            .resizable()
                            .frame(height:170)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
            Text(project.name ?? "Title for this project is this")
                .font(.title2)
                .bold()
            ProgressBar(moneyAcquired: project.moneyAcquired ?? 0, moneyGoal: project.moneyGoal ?? 0)
                .padding()
            HStack {
                CustomDetailComponent(project: project, componentType: DetailComponentType.funded)
                Spacer()
                CustomDetailComponent(project: project, componentType: DetailComponentType.backers)

                Spacer()
                CustomDetailComponent(project: project, componentType: DetailComponentType.days)

            }
            .padding()
            Spacer()
        }
        .frame(height: 350)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.15), radius: 20, x: 0, y: 0)
        .padding()
    }
}

#Preview {
    ProjectCard(project: Project(id: 205, name: "Asdasd", projectPictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/fundster-f5983.appspot.com/o/projectImages%2FB293AD92-8254-47D0-9664-585B3B127D6E?alt=media&token=1530e9f6-850e-45a4-988e-f83884dba5e4", description: "Description", moneyGoal: 12341, moneyAcquired: 123, backers: 0, deadline: Date(), userID: 1))
}
