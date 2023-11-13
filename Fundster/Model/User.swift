//
//  User.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
struct User: Codable, Identifiable {
    var id: Int?
    var name: String?
    var email: String?
    var role: Role?
    var profilePictureUrl: String?
    var phoneNumber: String?
    var password: String?
    var projects: [Project]?
    var favouriteProjects: [Project]?
}
