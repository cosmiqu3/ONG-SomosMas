//
//  RegistryResponse.swift
//  ONG-SomosMas
//
//  Created by training on 15-06-22.
//

import Foundation

struct RegistryResponse: Codable {
    
    let success: Bool?
    let data: DataClassResponse?
    let message: String
    let errors: ErrorsResponse?
    
}
