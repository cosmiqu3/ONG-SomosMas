//
//  TestimonialsResponse.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import Foundation

struct TestimonialsResponse: Codable {
    let success: Bool
    let data: [DatumResponse]
    let message: String
}
