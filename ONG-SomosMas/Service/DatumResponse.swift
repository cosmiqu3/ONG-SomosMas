//
//  DatumResponse.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import Foundation

struct DatumResponse: Codable {
    let id: Int
    let name: String
    let image: String
    let datumDescription, createdAt, updatedAt, deletedAt: String?
    let groupID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case datumDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case groupID = "group_id"
    }
}
