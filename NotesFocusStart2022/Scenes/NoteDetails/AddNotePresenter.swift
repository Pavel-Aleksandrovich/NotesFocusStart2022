//
//  AddNotePresenter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNotePresenter {
    func loadView(viewController: AddNoteViewController, view: AddNoteView)
    func getImageFromImagePicker(image: UIImage)
}

final class AddNotePresenterImpl: AddNotePresenter {
     
    private weak var viewController: AddNoteViewController?
    private weak var view: AddNoteView?
    private let interactor: NotesInteractor
    private let router: AddNoteRouter
    private let index: Int?
    
    init(interactor: NotesInteractor, router: AddNoteRouter, index: Int?) {
        self.interactor = interactor
        self.router = router
        self.index = index
    }
    
    func loadView(viewController: AddNoteViewController, view: AddNoteView) {
        self.viewController = viewController
        self.view = view
        addSaveButtonTappedHandler()
        getNoteByIndex()
    }
    
    private func getNoteByIndex() {
        guard let index = index else { return }
        let note = interactor.getTaskByIndex(index: index)
        view?.configure(note: note)
    }
    
    private func addSaveButtonTappedHandler() {
        view?.saveButtonTappedHandler = { [ weak self ] note in
            self?.handleSaveTapped(note: note, index: self?.index)
        }
    }
    
    private func handleSaveTapped(note: NoteEntity, index: Int?) {
        if needCreateNewNote(index: index) {
            saveNoteToStorage(note: note)
        } else {
            updateNoteByIndex(note: note, index: index!)
        }
    }
    
    private func needCreateNewNote(index: Int?) -> Bool {
        return index == nil
    }
    
    private func saveNoteToStorage(note: NoteEntity) {
        interactor.createTask(task: note)
        router.dismissAddNote()
    }
    
    private func updateNoteByIndex(note: NoteEntity, index: Int) {
        interactor.updateNoteByIndex(note: note, index: index)
        router.dismissAddNote()
    }
    
    func getImageFromImagePicker(image: UIImage) {
        view?.getImageFromImagePicker(image: image)
    }
}
