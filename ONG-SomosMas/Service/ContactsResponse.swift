//
//  ContactResponse.swift
//  ONG-SomosMas
//
//  Created by training on 20-06-22.
//

import Foundation

struct ContactsResponse: Codable {
    let success: Bool?
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let name, email, phone: String?
    let message: String
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, email, phone, message
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
