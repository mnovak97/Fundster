//
//  ProjectDetailViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import Foundation
class ProjectDetailViewModel: ObservableObject {
    @Published var project : Project
    @Published var projectUser: User?
    let projectService = ProjectService()
    let userService = UserService()
    
    init(project: Project) {
        self.project = project
        self.fetchProjectUser()
    }
    func fetchProjectUser() {
        Task {
            if let id = UserSessionManager.shared.retrieveUserID() {
                if let token = UserSessionManager.shared.retrieveUserToken() {
                    let user = try await userService.getUser(withID: id, token: token)
                    DispatchQueue.main.async {
                        self.projectUser = user
                    }
                }
            }
        }
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
