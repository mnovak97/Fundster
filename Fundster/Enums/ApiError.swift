//
//  UserError.swift
//  Fundster
//
//  Created by Martin Novak on 30.10.2023..
//

import Foundation
enum ApiError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
