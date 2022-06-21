//
//  News.swift
//  ONG-SomosMas
//
//  Created by training on 20-06-22.
//

import Foundation

struct News: Hashable {
    
    var name: String
    var content: String
    var image: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: News, rhs: News) -> Bool {
        return lhs.name == rhs.name
    }
}
