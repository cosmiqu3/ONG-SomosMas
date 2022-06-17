//
//  NewsResponse.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import Foundation

struct NewsResponse: Codable {
    let success: Bool?
    let data: [DatumNewsResponse]
    let message: String
}
