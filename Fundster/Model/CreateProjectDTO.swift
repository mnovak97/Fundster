//
//  CreateProjectDTO.swift
//  Fundster
//
//  Created by Martin Novak on 09.11.2023..
//

import Foundation
struct CreateProjectDTO : Codable {
    var name: String?
    var projectPictureUrl: String?
    var description: String?
    var moneyGoal: Int?
    var deadline: Date?
    var userID: Int?
}
