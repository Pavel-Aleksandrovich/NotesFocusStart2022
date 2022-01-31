//
//  NotesListPresenter.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListPresenter {
    func loadView(viewController: NotesListViewController, view: NotesListView)
}

final class NotesListPresenterImpl: NotesListPresenter {
    
    private weak var viewController: NotesListViewController?
    private weak var view: NotesListView?
    
    func loadView(viewController: NotesListViewController, view: NotesListView) {
        self.viewController = viewController
        self.view = view
    }
    
    
}
