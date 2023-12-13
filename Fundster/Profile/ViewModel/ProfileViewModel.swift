//
//  ProfileViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 14.11.2023..
//

import Foundation
import SwiftUI

class ProfileViewModel : ObservableObject {
    @Published private (set) var user: User?
    
    private let userService = UserService()
    
    init() {
        self.fetchUserData()
    }
    
    func uploadUserProfilePicture(_ image: UIImage) {
        ImageUploader().uploadProjectImage(image: image, projectImage: false) { profilePictureUrl in
            Task {
                do {
                    self.user?.profilePictureUrl = profilePictureUrl
                    if let token = UserSessionManager.shared.retrieveUserToken() {
                        if let user = self.user {
                            try await self.userService.updateUser(updatedUser: user, token: token)
                        }
                    }
                } catch {
                    print("Error while updating!")
                }
            }
        }
    }
    
    func fetchUserData() {
        Task {
            if let id = UserSessionManager.shared.retrieveUserID() {
                if let token = UserSessionManager.shared.retrieveUserToken() {
                    let user = try await userService.getUser(withID: id, token: token)
                    DispatchQueue.main.async {
                        self.user = user
                    }
                }
            }
        }
    }
}
