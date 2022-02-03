//
//  AddNoteAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class AddNoteAssembly {
    
    static func build() -> UIViewController {
        
        let router = AddNoteRouterImpl()
        let noteSettings = NoteSettingsImpl()
        let presenter = AddNotePresenterImpl(noteSettings: noteSettings, router: router)
        let viewController = AddNoteViewControllerImpl(presenter: presenter)
        router.controller = viewController
        
        return viewController
    }
}
