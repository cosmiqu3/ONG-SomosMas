//
//  LoginResponse.swift
//  ONG-SomosMas
//
//  Created by training on 22-06-22.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool?
    let data: DataLoginClass?
    let message: String?
    let error: String?
}

// MARK: - DataLoginClass
struct DataLoginClass: Codable {
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name, email: String
    let emailVerifiedAt: String?
    let password: String
    let roleID: Int
    let groupID: Int?
    let rememberToken: Bool?
    let createdAt, updatedAt, deletedAt: String?
    let latitude, longitude: Double?
    let address, profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case password
        case roleID = "role_id"
        case rememberToken = "remember_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case groupID = "group_id"
        case latitude, longitude, address
        case profileImage = "profile_image"
    }
}
