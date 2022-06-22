//
//  Staff.swift
//  ONG-SomosMas
//
//  Created by training on 21-06-22.
//

import Foundation

struct Staff: Hashable {
    
    var name: String
    var role: String
    var description: String
    var image: String
    var letterSize: Int
    var letterPosition: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(lhs: Staff, rhs: Staff) -> Bool {
        return lhs.name == rhs.name
    }
}
