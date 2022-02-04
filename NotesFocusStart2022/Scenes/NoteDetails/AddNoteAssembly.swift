//
//  AddNoteAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class AddNoteAssembly {
    
    static func build(index: Int?) -> UIViewController {
        
        let router = AddNoteRouterImpl()
        let noteSettings = NoteSettingsImpl()
        let interactor = NotesInteractor(noteSettings: noteSettings)
        let presenter = AddNotePresenterImpl(interactor: interactor, router: router, index: index)
        let viewController = AddNoteViewControllerImpl(presenter: presenter)
        router.controller = viewController
        
        return viewController
    }
}
