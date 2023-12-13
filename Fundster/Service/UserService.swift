//
//  UserService.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
struct UserService {
    let endpoint = "http://localhost:8080/api/users"
    
    func getUsers(token: String) async throws -> [User] {
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode([User].self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func updateUser(updatedUser:User, token: String) async throws {
        if let id = updatedUser.id {
            guard let url = URL(string: endpoint + "/\(id)") else {
                throw ApiError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
                let jsonData = try encoder.encode(updatedUser)
                request.httpBody = jsonData
                
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw ApiError.invalidResponse
                }
                
                print("User updated successfully")
            } catch {
                throw ApiError.invalidData
            }
        }
    }
    
    func createUser(user: CreateUserDTO) async throws -> User {
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw ApiError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let createdUser = try decoder.decode(User.self, from: data)

            return createdUser
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func getUserProjects(with id: Int, token:String) async throws -> [Project] {
        guard let url = URL(string: endpoint + "/\(id)/Projects") else {
            throw ApiError.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode([Project].self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func getUser(withID id: Int, token: String) async throws -> User {
        guard let url = URL(string: endpoint + "/\(id)") else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return try decoder.decode(User.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func loginUser(email:String, password: String) async throws -> String {
        guard let url = URL(string: endpoint + "/login") else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["email": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let token = String(data: data, encoding: .utf8) {
                return token
        } else {
            throw ApiError.invalidResponse
        }
    }
    
    
}
