//
//  NotesListRouter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListRouter {
    func presentAddNote(index: Int?)
}

final class NotesListRouterImpl: NotesListRouter {
    
    weak var controller: UIViewController?
    
    func presentAddNote(index: Int?) {
        let addNote = NoteDetailsAssembly.build(index: index)
        controller?.navigationController?.pushViewController(addNote, animated: false)
    }
    
}
