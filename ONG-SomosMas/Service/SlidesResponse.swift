//
//  SlideResponse.swift
//  ONG-SomosMas
//
//  Created by training on 20-06-22.
//

import Foundation

struct SlidesResponse: Codable {
    let success: Bool?
    let data: [DatumSlidesResponse]
    let message: String
}

struct DatumSlidesResponse : Codable {
    
    let id: Int
    let name, datumDescription: String
    let order: Int
    let image: String?
    let userID, groupID: Int?
    let createdAt, updatedAt, deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, order
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case groupID = "group_id"
    }
}
