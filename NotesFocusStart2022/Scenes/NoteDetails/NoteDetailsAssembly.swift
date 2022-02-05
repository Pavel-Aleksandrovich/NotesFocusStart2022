//
//  AddNoteAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NoteDetailsAssembly {
    
    static func build(index: Int?) -> UIViewController {
        
        let router = NoteDetailsRouterImpl()
        let notesStorage = NotesStorageImpl()
        let interactor = NotesInteractor(notesStorage: notesStorage)
        let presenter = NoteDetailsPresenterImpl(interactor: interactor, router: router, index: index)
        let viewController = NoteDetailsViewControllerImpl(presenter: presenter)
        router.controller = viewController
        
        return viewController
    }
}
