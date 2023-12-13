//
//  AdminViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import Foundation
class AdminViewModel : ObservableObject {
    @Published var users = [User]()
    
    let userService = UserService()
    let projectService = ProjectService()
    
    init() {
        fetchUsers()
    }
    func deleteProject(user: User, projectIndex: Int) {
        Task {
            if let token = UserSessionManager.shared.retrieveUserToken() {
                let projectToDelete = user.projects?[projectIndex]
                try await projectService.deleteProject(projectID: projectToDelete?.id, token: token)
                fetchUsers()
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
}
