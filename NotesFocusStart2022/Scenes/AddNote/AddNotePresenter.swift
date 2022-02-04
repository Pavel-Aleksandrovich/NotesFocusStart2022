//
//  AddNotePresenter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNotePresenter {
    func loadView(viewController: AddNoteViewController, view: AddNoteView)
}

final class AddNotePresenterImpl: AddNotePresenter {
     
    private weak var viewController: AddNoteViewController?
    private weak var view: AddNoteView?
    private var noteSettings: NoteSettings
    private let router: AddNoteRouter
    private let index: Int?
    
    init(noteSettings: NoteSettings, router: AddNoteRouter, index: Int?) {
        self.noteSettings = noteSettings
        self.router = router
        self.index = index
    }
    
    func loadView(viewController: AddNoteViewController, view: AddNoteView) {
        self.viewController = viewController
        self.view = view
        saveNote()
        getNoteByIndex()
    }
    
    private func getNoteByIndex() {
        guard let index = index else { return }
        let note = noteSettings.getTaskByIndex(index: index)
        view?.configure(note: note)
    }
    
    private func saveNote() {
        
        view?.saveButtonTappedHandler = { note in
            self.noteSettings.saveTask(task: note)
            self.router.dismissAddNote()
        }
    }
}
