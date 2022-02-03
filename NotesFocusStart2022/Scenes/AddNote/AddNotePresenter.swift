//
//  AddNotePresenter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNotePresenter {
    func loadView(viewController: AddNoteViewController, view: AddNoteView)
}

final class AddNotePresenterImpl: AddNotePresenter {
     
    private weak var viewController: AddNoteViewController?
    private weak var view: AddNoteView?
    
    func loadView(viewController: AddNoteViewController, view: AddNoteView) {
        self.viewController = viewController
        self.view = view
    }
}
