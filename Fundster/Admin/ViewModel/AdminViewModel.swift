//
//  AdminViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import Foundation
class AdminViewModel : ObservableObject {
    @Published var users = [User]()
    @Published var projects = [Project]()
    
    let userService = UserService()
    let projectService = ProjectService()
    
    init() {
        fetchUsers()
        fetchProjects()
    }
    func deleteProject(project: Project) {
        Task {
            if let token = UserSessionManager.shared.retrieveUserToken() {
                try await projectService.deleteProject(projectID: project.id, token: token)
                DispatchQueue.main.async {
                    self.projects.removeAll { $0.id == project.id}
                }
                
            }
        }
    }
    
    func fetchUsers() {
        Task {
            if let token = UserSessionManager.shared.retrieveUserToken() {
                let users = try await userService.getUsers(token: token)
                DispatchQueue.main.async {
                    self.users = users
                }
            }
        }
    }
    
    func fetchProjects() {
        Task {
            if let token = UserSessionManager.shared.retrieveUserToken() {
                let projects = try await projectService.getProjects(token: token)
                DispatchQueue.main.async {
                    self.projects = projects
                }
            }
        }
    }
}
