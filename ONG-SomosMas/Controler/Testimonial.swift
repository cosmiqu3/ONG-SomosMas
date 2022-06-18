//
//  Testimonials.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import Foundation

struct Testimonial: Hashable {
    
    var name: String
    var description: String
    var photo: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func ==(lhs: Testimonial, rhs: Testimonial) -> Bool {
        return lhs.name == rhs.name
    }
}
