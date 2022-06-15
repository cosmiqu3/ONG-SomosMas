//
//  DataClassResponse.swift
//  ONG-SomosMas
//
//  Created by training on 15-06-22.
//

import Foundation

struct DataClassResponse: Codable {
    
    let user: UserResponse
    let token: String
    
}
