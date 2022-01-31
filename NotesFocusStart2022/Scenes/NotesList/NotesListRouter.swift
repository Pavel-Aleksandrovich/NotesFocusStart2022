//
//  NotesListRouter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListRouter {
    func presentAddNote(controller: UIViewController)
}

final class NotesListRouterImpl: NotesListRouter {
    
    func presentAddNote(controller: UIViewController) {
        let addNote = AddNoteAssembly.build()
        controller.navigationController?.pushViewController(addNote, animated: false)
    }
}
