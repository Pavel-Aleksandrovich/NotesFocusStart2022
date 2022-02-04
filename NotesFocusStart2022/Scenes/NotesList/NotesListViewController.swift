//
//  ViewController.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListViewController: AnyObject {
    var addNoteButtonTappedHandler: (() -> ())? { get set }
}

final class NotesListViewControllerImpl: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesListViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let rowHeight: CGFloat = 80
        static let title = "Notes"
    }
    
    private let presenter: NotesListPresenter
    private let tableView = UITableView()
    
    var addNoteButtonTappedHandler: (() -> ())?
    
    init(presenter: NotesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadView(viewController: self)
        addNoteButton()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureView() {
        title = Constants.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addNoteButton() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteButtonTapped))
        self.navigationItem.rightBarButtonItem = addNoteButton
    }
    
    @objc private func addNoteButtonTapped() {
        self.addNoteButtonTappedHandler?()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! NoteCell
        
        let note = presenter.getNoteByIndex(index: indexPath.row)
        cell.configure(note: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentNoteDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeNoteAtIndex(index: indexPath.row)
            tableView.reloadData()
        }
    }
}

