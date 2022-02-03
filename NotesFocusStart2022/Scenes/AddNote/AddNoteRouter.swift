//
//  AddNoteRouter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNoteRouter {
    func dismissAddNote()
}

final class AddNoteRouterImpl: AddNoteRouter {
    
    weak var controller: UIViewController?
    
    func dismissAddNote() {
        controller?.navigationController?.popViewController(animated: false)
    }
}
