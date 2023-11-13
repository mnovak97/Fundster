//
//  ProjectDetailViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import Foundation
class ProjectDetailViewModel: ObservableObject {
    @Published var project : Project
    let projectService = ProjectService()
    
    init(project: Project) {
        self.project = project
    }
    
    func updateProject(money: Int) {
        if var moneyAcquired = project.moneyAcquired {
            moneyAcquired += money
            project.moneyAcquired = moneyAcquired
        } else {
            project.moneyAcquired = money
        }
        if var currentBackers = project.backers {
            currentBackers += 1
            project.backers = currentBackers
        } else {
        
            project.backers = 1
        }
        Task {
            do {
                if let token = UserSessionManager.shared.retrieveUserToken() {
                    try await projectService.updateProject(updatedProject: project, token: token)
                }
            } catch {
                print("Error while updating!")
            }
        }
    }
}
