//
//  ViewController.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListViewController: AnyObject {
    
}

final class NotesListViewControllerImpl: UIViewController, NotesListViewController {
    
    private let notesListView: NotesListView
    private let presenter: NotesListPresenter
    
    init(presenter: NotesListPresenter) {
        self.notesListView = NotesListViewImpl()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(viewController: self, view: notesListView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = (notesListView as! UIView)
    }
}

