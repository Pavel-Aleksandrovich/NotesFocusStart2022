//
//  NotesListPresenter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListPresenter {
    func loadView(viewController: NotesListViewController)
    func getNoteByIndex(index: Int) -> NoteEntity
    func numberOfNotes() -> Int
}

final class NotesListPresenterImpl: NotesListPresenter{
    
    private weak var viewController: NotesListViewController?
    private let router: NotesListRouter
    private var noteSettings: NoteSettings
    
    init(router: NotesListRouter, noteSettings: NoteSettings) {
        self.router = router
        self.noteSettings = noteSettings
    }
    
    func loadView(viewController: NotesListViewController) {
        self.viewController = viewController
        
        presentAddNote()
    }
    
    private func presentAddNote() {
        viewController?.addNoteButtonTappedHandler = { controller in
            self.router.presentAddNote(controller: controller)
        }
    }
    
    func getNoteByIndex(index: Int) -> NoteEntity {
        return noteSettings.getTaskByIndex(index: index)
    }
    
    func numberOfNotes() -> Int {
        return noteSettings.numberOfTasks()
    }
}
