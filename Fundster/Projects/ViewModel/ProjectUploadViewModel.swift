//
//  ProjectUploadViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 07.11.2023..
//

import Foundation
import SwiftUI

class ProjectUploadViewModel : ObservableObject {
    private let projectService = ProjectService()
    
    func uploadProject(_ image: UIImage, name: String, desc: String, projectDeadline: Date, moneyGoal: Int) {
        if let id = UserSessionManager.shared.retrieveUserID() {
            ImageUploader().uploadProjectImage(image: image, projectImage: true) { pictureUrl in
                Task {
                    do {
                        let project = CreateProjectDTO(name: name,projectPictureUrl: pictureUrl,description: desc,moneyGoal: moneyGoal,deadline: projectDeadline,userID: id)
                        if let token = UserSessionManager.shared.retrieveUserToken() {
                            try await self.projectService.createProject(project: project, token: token)
                        }
                    } catch {
                        print("There was an error uploading the project!")
                    }
                }
            }
        }
    }
}
