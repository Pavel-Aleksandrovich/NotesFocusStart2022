//
//  Entity.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import Foundation

struct Entity {
    let title: String = "title"
    let description: String = "desc"
    
}
extension Entity: Hashable {
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.title)
//    }
//    
//    static func == (lhs: Entity, rhs: Entity) -> Bool {
//        lhs.title == rhs.title
//    }
    
}
