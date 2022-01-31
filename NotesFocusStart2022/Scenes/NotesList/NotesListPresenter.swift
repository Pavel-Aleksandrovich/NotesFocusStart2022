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

final class NotesListPresenterImpl: NotesListPresenter, NotesListTableAdapterDelegate {
    
    
    private weak var viewController: NotesListViewController?
    private weak var view: NotesListView?
    private let tableAdapter: NotesListTableAdapter
    private let router: NotesListRouter
    
    init(tableAdapter: NotesListTableAdapter, router: NotesListRouter) {
        self.tableAdapter = tableAdapter
        self.router = router
    }
    
    func loadView(viewController: NotesListViewController, view: NotesListView) {
        self.viewController = viewController
        self.view = view
        
        tableAdapter.tableView = self.view?.getTableView()
        tableAdapter.delegate = self
        
        presentAddNote()
    }
    
    private func presentAddNote() {
        viewController?.addNoteButtonTappedHandler = { controller in
            self.router.presentAddNote(controller: controller)
        }
    }
    
    func didSelectItem(title: String) {
    }
    
}
