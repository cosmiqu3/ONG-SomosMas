//
//  DatumNewsResponse.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import Foundation

struct DatumNewsResponse : Codable {
    
    let id: Int
    let name: String
    let slug: String?
    let content: String
    let image: String?
    let userID, groupID, categoryID: Int?
    let createdAt, updatedAt, deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, content, image
        case userID = "user_id"
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case groupID = "group_id"
    }
    
}
