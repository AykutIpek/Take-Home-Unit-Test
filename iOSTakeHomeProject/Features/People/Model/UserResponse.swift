//
//  UserResponse.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
