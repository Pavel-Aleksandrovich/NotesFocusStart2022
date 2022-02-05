//
//  NotesStorage.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 03.02.2022.
//

import Foundation

protocol NotesStorage {
    func createNote(note: NoteEntity)
    func removeNote(index: Int)
    func numberOfNotes() -> Int
    func getNoteByIndex(index: Int) -> NoteEntity
    func updateNoteByIndex(note: NoteEntity, index: Int)
}

final class NotesStorageImpl: NotesStorage {
    
    private enum StorageKey {
        static let noteEntity = "noteEntity"
    }
    
    private var notes: [NoteEntity]! {
        get {
            guard let data = UserDefaults.standard.object(forKey: StorageKey.noteEntity) as? Data,
                  let decodeModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [NoteEntity] else { return [NoteEntity(title: "title", descriptionText: "description", noteImage: #imageLiteral(resourceName: "DefaultProfileImage"))] }
            return decodeModel
        } set {
            if let model = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    UserDefaults.standard.set(saveData, forKey: StorageKey.noteEntity)
                }
            }
        }
    }
    
    func createNote(note: NoteEntity) {
        notes.insert(note, at: 0)
    }

    func removeNote(index: Int) {
        notes.remove(at: index)
    }

    func numberOfNotes() -> Int {
        return notes.count
    }

    func getNoteByIndex(index: Int) -> NoteEntity {
        return notes[index]
    }

    func updateNoteByIndex(note: NoteEntity, index: Int) {
        notes.remove(at: index)
        notes.insert(note, at: index)
    }
}
