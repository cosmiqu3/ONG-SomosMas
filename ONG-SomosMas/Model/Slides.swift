//
//  Slides.swift
//  ONG-SomosMas
//
//  Created by Training on 22-06-22.
//

import Foundation
struct Slides: Hashable {
    
    var name: String
    var content: String
    var image: String
    var data: Data
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: Slides, rhs: Slides) -> Bool {
        return lhs.name == rhs.name
    }
}
