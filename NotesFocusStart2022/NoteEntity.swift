//
//  Entity.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import Foundation

class NoteEntity: NSObject, NSCoding {
    let title: String
//    let description: String = "desc"
    
    private enum SettingsKey {
        static let title = "title"
    }
    
    init(title: String) {
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: SettingsKey.title) as? String ?? "nil"
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: SettingsKey.title)
        
    }
    
}
//extension NoteEntity: Hashable {
//
////    func hash(into hasher: inout Hasher) {
////        hasher.combine(self.title)
////    }
////
////    static func == (lhs: Entity, rhs: Entity) -> Bool {
////        lhs.title == rhs.title
////    }
//
//}
