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
    
    init(noteSettings: NoteSettings, router: AddNoteRouter) {
        self.noteSettings = noteSettings
        self.router = router
    }
    
    func loadView(viewController: AddNoteViewController, view: AddNoteView) {
        self.viewController = viewController
        self.view = view
        saveNote()
    }
    
    private func saveNote() {
        
        view?.saveButtonTappedHandler = { note in
            self.noteSettings.saveTask(task: note)
            self.router.dismissAddNote()
        }
    }
}
