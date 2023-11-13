//
//  ProjectsModelView.swift
//  Fundster
//
//  Created by Martin Novak on 09.11.2023..
//

import Foundation
class ProjectsViewModel: ObservableObject {
    @Published private (set) var userProjects = [Project]()
    
    let userService = UserService()
    
    init() {
        fetchUserProjects()
    }
    func clearProjects() {
        self.userProjects = [Project]()
    }
    
    func fetchUserProjects() {
        Task {
            do {
                if let id = UserSessionManager.shared.retrieveUserID() {
                    if let token = UserSessionManager.shared.retrieveUserToken() {
                        let fetchedUserProjects = try await userService.getUserProjects(with: id, token: token)
                        DispatchQueue.main.async {
                            self.userProjects = fetchedUserProjects
                        }
                    }
                }
            } catch {
                print("There was an error fetching user projects!")
            }
        }
    }
}
