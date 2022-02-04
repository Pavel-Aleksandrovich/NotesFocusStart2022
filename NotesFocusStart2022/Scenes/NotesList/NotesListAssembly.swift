//
//  NotesListAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NotesListAssembly {
    
    static func build() -> UIViewController {
        
        let noteSettings = NoteSettingsImpl()
        let router = NotesListRouterImpl()
        let presenter = NotesListPresenterImpl(router: router, noteSettings: noteSettings)
        let viewController = NotesListViewControllerImpl(presenter: presenter)
        router.controller = viewController
        
        return viewController
    }
}
