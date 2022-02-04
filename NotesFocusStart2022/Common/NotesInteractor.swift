//
//  NotesInteractor.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 04.02.2022.
//

import Foundation

final class NotesInteractor {
    
    private let noteSettings: NoteSettings
    
    init(noteSettings: NoteSettings) {
        self.noteSettings = noteSettings
    }
    
    func createTask(task: NoteEntity) {
        noteSettings.saveTask(task: task)
    }

    func removeTask(index: Int) {
        noteSettings.removeTask(index: index)
    }

    func numberOfTasks() -> Int {
        return noteSettings.numberOfTasks()
    }

    func getTaskByIndex(index: Int) -> NoteEntity {
        return noteSettings.getTaskByIndex(index: index)
    }

    func updateNoteByIndex(note: NoteEntity, index: Int) {
        noteSettings.updateNoteByIndex(note: note, index: index)
    }
}
