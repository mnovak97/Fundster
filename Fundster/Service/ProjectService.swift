//
//  ProjectService.swift
//  Fundster
//
//  Created by Martin Novak on 31.10.2023..
//

import Foundation
struct ProjectService {
    let endpoint = "http://localhost:8080/api/projects"
    let imageUploader = ImageUploader()
    
    func createProject(project: CreateProjectDTO, token: String) async throws {
        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(project)
            request.httpBody = jsonData
            
            let (_,response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw ApiError.invalidResponse
            }
            
            print("Project created successfully")
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func updateProject(updatedProject: Project, token:String) async throws {
        if let id = updatedProject.id {
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
                let jsonData = try encoder.encode(updatedProject)
                request.httpBody = jsonData
                
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw ApiError.invalidResponse
                }
                
                print("Project updated successfully")
            } catch {
                throw ApiError.invalidData
            }
        }
    }
    
    func deleteProject(projectID: Int? , token: String) async throws {
        if let id = projectID {
            guard let url = URL(string: endpoint + "/\(id)") else {
                throw ApiError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            do {
                let (_, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw ApiError.invalidResponse
                }
                print("Project deleted successfully")
            } catch {
                throw ApiError.invalidData
            }
            
        }
    }
    
    func getProjects(token: String) async throws -> [Project] {
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
            return try decoder.decode([Project].self, from: data)
        } catch {
            throw ApiError.invalidData
        }
        
    }
}
