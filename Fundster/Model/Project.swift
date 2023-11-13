//
//  Project.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
struct Project : Codable, Identifiable {
    var id: Int?
    var name: String?
    var projectPictureUrl: String?
    var description: String?
    var moneyGoal: Int?
    var moneyAcquired: Int?
    var backers: Int?
    var deadline: Date?
    var userID: Int?
}
