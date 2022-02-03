//
//  AddNoteViewController.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNoteViewController: AnyObject {
    
}

final class AddNoteViewControllerImpl: UIViewController, AddNoteViewController {
    
    private let addNoteView: AddNoteView
    private let presenter: AddNotePresenter
    
    
    init(presenter: AddNotePresenter) {
        self.presenter = presenter
        addNoteView = AddNoteViewImpl()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadView(viewController: self, view: addNoteView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addNoteView
        
        title = "AddNoteViewControllerImpl"
    }
    
}
