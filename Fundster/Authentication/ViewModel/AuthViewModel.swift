//
//  AuthViewModel.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
import JWTDecode

class AuthViewModel : ObservableObject {
    @Published var currentUser: User?
    @Published var token: String = ""
    @Published var error: Error?
    @Published var projectUpdated = false
    
    private let userService = UserService()
    
    func login(email: String, password: String) {
        Task {
            do {
                let token = try await userService.loginUser(email: email, password: password)
                if !token.isEmpty {
                    if let id = getCurrentUserID(withToken: token) {
                        if let jwt = getJwtToken(jsonToken: token) {
                            UserSessionManager.shared.saveUserToken(token: jwt)
                            let user = try await userService.getUser(withID: id, token: jwt)
                            UserSessionManager.shared.saveUserID(id: id)
                            DispatchQueue.main.async {
                                self.token = token
                                self.currentUser = user
                            }
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
    
    func createUser(user: CreateUserDTO) {
        Task {
            let user = try await userService.createUser(user: user)
        }
    }
    
    func logout() {
        self.currentUser = nil
        UserSessionManager.shared.clearUserID()
        UserSessionManager.shared.clearUserToken()
    }
    func getJwtToken(jsonToken: String) -> String? {
        do {
            if let jsonData = jsonToken.data(using: .utf8) {
                let tokenObject = try JSONDecoder().decode(JwtToken.self, from: jsonData)
                return tokenObject.token
            }
        } catch {
            print("Failed to decode JWT!")
        }
        return nil
    }
    
    func getCurrentUserID(withToken token: String) -> Int? {
        do {
            if let jsonData = token.data(using: .utf8) {
                let tokenResponse = try JSONDecoder().decode(JwtToken.self, from: jsonData)
                let jwt = try decode(jwt: tokenResponse.token)
                if let userId = jwt.body["user_id"] as? Int {
                    return userId
                } else {
                    print("User ID not found in the JWT.")
                }
            }
        } catch {
            print("Failed to decode JWT: \(error)")
        }
        return nil
    }
    
}
