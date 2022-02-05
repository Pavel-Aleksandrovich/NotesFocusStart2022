//
//  NotesInteractor.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 04.02.2022.
//

import Foundation

final class NotesInteractor {
    
    private let notesStorage: NotesStorage
    
    init(notesStorage: NotesStorage) {
        self.notesStorage = notesStorage
    }
    
    func createNote(note: NoteEntity) {
        notesStorage.createNote(note: note)
    }

    func removeNote(index: Int) {
        notesStorage.removeNote(index: index)
    }

    func numberOfNotes() -> Int {
        return notesStorage.numberOfNotes()
    }

    func getNoteByIndex(index: Int) -> NoteEntity {
        return notesStorage.getNoteByIndex(index: index)
    }

    func updateNoteByIndex(note: NoteEntity, index: Int) {
        notesStorage.updateNoteByIndex(note: note, index: index)
    }
}
