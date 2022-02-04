//
//  Entity.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import Foundation

class NoteEntity: NSObject, NSCoding {
    let title: String
    let descriptionText: String
    
    private enum SettingsKey {
        static let title = "title"
        static let descriptionText = "descriptionText"
    }
    
    init(title: String, descriptionText: String) {
        self.title = title
        self.descriptionText = descriptionText
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: SettingsKey.title) as? String ?? ""
        descriptionText = coder.decodeObject(forKey: SettingsKey.descriptionText) as? String ?? ""
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: SettingsKey.title)
        coder.encode(descriptionText, forKey: SettingsKey.descriptionText)
    }
    
}
