//
//  AddNoteRouter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NoteDetailsRouter {
    func dismissAddNote()
}

final class NoteDetailsRouterImpl: NoteDetailsRouter {
    
    weak var controller: UIViewController?
    
    func dismissAddNote() {
        controller?.navigationController?.popViewController(animated: false)
    }
}
