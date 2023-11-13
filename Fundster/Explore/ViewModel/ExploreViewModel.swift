//
//  ExploreViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 09.11.2023..
//

import Foundation
class ExploreViewModel : ObservableObject {
    @Published private (set) var projects = [Project]()
    @Published var searchText = ""
    let projectService = ProjectService()
    
    init() {
        fetchProjects()
    }
    
    var searchableProjects: [Project] {
        if searchText.isEmpty {
            return projects
        } else {
            return projects.filter { $0.name!.contains(searchText) }
        }
    }
    
    func clearProjects() {
        self.projects = [Project]()
    }
    func fetchProjects() {
        Task {
            do {
                if let token = UserSessionManager.shared.retrieveUserToken() {
                    let fetchedProjects = try await projectService.getProjects(token: token)
                    DispatchQueue.main.async {
                        self.projects = fetchedProjects
                    }
                }
            } catch {
                print("There was an error fetching projects!")
            }
        }
    }
}
