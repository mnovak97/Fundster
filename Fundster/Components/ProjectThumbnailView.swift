//
//  ProjectThumbnailView.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct ProjectThumbnailView: View {
    @State var project: Project
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: project.projectPictureUrl ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Tsunami_by_hokusai_19th_century.jpg/700px-Tsunami_by_hokusai_19th_century.jpg"),
                    content: { image in
                        image
                            .resizable()
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 250)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
            .cornerRadius(15)
            VStack {
                Text(project.description ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    .frame(height: 50)
                ProgressBar(moneyAcquired: project.moneyAcquired ?? 0, moneyGoal: project.moneyGoal ?? 0)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("\(calculatePercentage(moneyAcquired: project.moneyAcquired, moneyGoal: project.moneyGoal))%")
                            .bold()
                        Spacer()
                        Image(systemName: "clock")
                        Text("\(daysUntil(date: project.deadline ?? Date()) ?? 0) days")
                            .bold()
                        Spacer()
                    }

            }
        }
        .padding(5)
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.15), radius: 20, x: 0, y: 0)
    }
}
func calculatePercentage(moneyAcquired: Int?, moneyGoal: Int?) -> String {
    let percentage = Double(moneyAcquired ?? 0) / Double(moneyGoal ?? 0) * 100
    let roundedPercentage = String(format: "%.1f", percentage)
    
    return roundedPercentage
}

func daysUntil(date: Date) -> Int? {
    let calendar = Calendar.current
    let currentDate = Date()

    let components = calendar.dateComponents([.day], from: currentDate, to: date)

    return components.day
}

struct ProjectThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectThumbnailView(project: Project(id: 205, name: "Asdasd", projectPictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/fundster-f5983.appspot.com/o/projectImages%2FB293AD92-8254-47D0-9664-585B3B127D6E?alt=media&token=1530e9f6-850e-45a4-988e-f83884dba5e4", description: "Description", moneyGoal: 12341, moneyAcquired: 0, backers: 0, deadline: Date(), userID: 1))
    }
}
