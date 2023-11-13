//
//  UserSessionManager.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
class UserSessionManager {
    static let shared = UserSessionManager()
    
    private let userDefaults = UserDefaults.standard
    private let userID = "user_id"
    private let tokenKey = "jwt_token"
    
    func saveUserToken(token: String) {
        userDefaults.set(token,forKey: tokenKey)
    }
    
    func clearUserToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    func retrieveUserToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    func saveUserID(id: Int) {
        userDefaults.set(id,forKey: userID)
    }
    
    func clearUserID() {
        userDefaults.removeObject(forKey: userID)
    }
    func retrieveUserID() -> Int? {
        return userDefaults.integer(forKey: userID)
    }
}
