//
//  SlideResponse.swift
//  ONG-SomosMas
//
//  Created by training on 20-06-22.
//

import Foundation

struct SlidesResponse: Codable {
    let success: Bool?
    let data: [DatumSlideResponse]
    let message: String
}
