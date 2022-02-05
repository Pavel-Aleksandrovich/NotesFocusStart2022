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
    func presentNoteDetails(index: Int)
    func removeNoteAtIndex(index: Int)
}

final class NotesListPresenterImpl: NotesListPresenter {
    
    private weak var viewController: NotesListViewController?
    private let router: NotesListRouter
    private let interactor: NotesInteractor
    
    init(router: NotesListRouter, interactor: NotesInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func loadView(viewController: NotesListViewController) {
        self.viewController = viewController
        presentAddNote()
    }
    
    private func presentAddNote() {
        viewController?.addNoteButtonTappedHandler = { [weak self] in
            self?.router.presentAddNote(index: nil)
        }
    }
    
    func getNoteByIndex(index: Int) -> NoteEntity {
        return interactor.getNoteByIndex(index: index)
    }
    
    func numberOfNotes() -> Int {
        return interactor.numberOfNotes()
    }
    
    func presentNoteDetails(index: Int) {
        router.presentAddNote(index: index)
    }
    
    func removeNoteAtIndex(index: Int) {
        interactor.removeNote(index: index)
    }
}
