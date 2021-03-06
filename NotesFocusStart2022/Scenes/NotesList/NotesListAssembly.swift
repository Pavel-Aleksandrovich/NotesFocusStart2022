//
//  NotesListAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NotesListAssembly {
    
    static func build() -> UIViewController {
        
        let notesStorage = NotesStorageImpl()
        let interactor = NotesInteractor(notesStorage: notesStorage)
        let router = NotesListRouterImpl()
        let presenter = NotesListPresenterImpl(router: router, interactor: interactor)
        let viewController = NotesListViewControllerImpl(presenter: presenter)
        router.controller = viewController
        
        return viewController
    }
}
