//
//  CustomDetailComponent.swift
//  Fundster
//
//  Created by Martin Novak on 19.10.2023..
//

import SwiftUI

struct CustomDetailComponent: View {
    @State var project: Project
    let componentType: DetailComponentType
    var body: some View {
        VStack {
            switch componentType {
            case .funded:
                fundedComponent(moneyAcquired: project.moneyAcquired ?? 0, moneyGoal: project.moneyGoal ?? 0)
            case .backers:
                backersComponent(backers: project.backers ?? 0)
            case .days:
                daysLeftComponent(date: project.deadline ?? Date())
            }
        }
    }
}
extension CustomDetailComponent {
    func fundedComponent(moneyAcquired: Int, moneyGoal: Int) -> some View {
        let percentage = Double(moneyAcquired) / Double(moneyGoal) * 100
        let roundedPercentage = String(format: "%.1f", percentage)
        return VStack {
            HStack{
                Image(systemName:"dollarsign.circle")
                Text("\(roundedPercentage)%")
                    .bold()
            }
            Text("Funded")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    func backersComponent(backers: Int) -> some View {
        VStack {
            HStack{
                Image(systemName:"person")
                Text("\(backers)")
                    .bold()
            }
            Text("Backers")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    func daysLeftComponent(date: Date) -> some View {
        VStack {
            HStack{
                Image(systemName:"clock")
                Text("\(daysUntil(date)!)")
                    .bold()
            }
            Text("Days left")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

func daysUntil(_ date: Date) -> Int? {
    let calendar = Calendar.current
    let currentDate = Date()

    let components = calendar.dateComponents([.day], from: currentDate, to: date)

    return components.day
}

struct CustomDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        CustomDetailComponent(project: Project(id: 205, name: "Asdasd", projectPictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/fundster-f5983.appspot.com/o/projectImages%2FB293AD92-8254-47D0-9664-585B3B127D6E?alt=media&token=1530e9f6-850e-45a4-988e-f83884dba5e4", description: "Description", moneyGoal: 12341, moneyAcquired: 3146, backers: 0, deadline: Date(), userID: 1), componentType: DetailComponentType.days)
    }
}
