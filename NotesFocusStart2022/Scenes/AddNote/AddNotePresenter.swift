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
        
        view?.saveButtonTappedHandler = { [ weak self ] note in
            if self?.index != nil {
                
                guard let index = self?.index else { return }
                self?.noteSettings.updateTaskByIndex(index: index, task: note)
                self?.router.dismissAddNote()
                
            } else {
                
                self?.noteSettings.saveTask(task: note)
                self?.router.dismissAddNote()
            }
            
        }
    }
    
    func getImageFromImagePicker(image: UIImage) {
        view?.getImageFromImagePicker(image: image)
    }
}
