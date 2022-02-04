//
//  Entity.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

class NoteEntity: NSObject, NSCoding {
    let title: String
    let descriptionText: String
    let noteImage: UIImage
    
    private enum SettingsKey {
        static let title = "title"
        static let descriptionText = "descriptionText"
        static let noteImage = "noteImage"
    }
    
    init(title: String, descriptionText: String, noteImage: UIImage) {
        self.title = title
        self.descriptionText = descriptionText
        self.noteImage = noteImage
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: SettingsKey.title) as? String ?? ""
        descriptionText = coder.decodeObject(forKey: SettingsKey.descriptionText) as? String ?? ""
        noteImage = coder.decodeObject(forKey: SettingsKey.noteImage) as? UIImage ?? #imageLiteral(resourceName: "DefaultProfileImage")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: SettingsKey.title)
        coder.encode(descriptionText, forKey: SettingsKey.descriptionText)
        coder.encode(noteImage, forKey: SettingsKey.noteImage)
    }
}
