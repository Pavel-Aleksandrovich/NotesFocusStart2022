//
//  ViewController.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NotesListViewController: AnyObject {
    var addNoteButtonTappedHandler: ((UIViewController) -> ())? { get set }
}

class NotesListViewControllerImpl: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesListViewController {
    
    private let presenter: NotesListPresenter
    private let tableView = UITableView()
    
    var addNoteButtonTappedHandler: ((UIViewController) -> ())?
    
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
    
    func configureView() {
        title = "NotesListViewControllerImpl"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotesListCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func addNoteButton() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteButtonTapped))
        self.navigationItem.rightBarButtonItem = addNoteButton
    }
    
    @objc private func addNoteButtonTapped() {
        self.addNoteButtonTappedHandler?(self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesListCell
        
        let note = presenter.getNoteByIndex(index: indexPath.row)
        cell.configure(note: note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfNotes()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

