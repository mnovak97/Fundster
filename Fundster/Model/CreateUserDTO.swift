//
//  CreateUserDTO.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import Foundation
struct CreateUserDTO: Codable {
    var name: String?
    var email: String?
    var role: Role?
    var profilePictureUrl: String?
    var phoneNumber: String?
    var password: String?
}
