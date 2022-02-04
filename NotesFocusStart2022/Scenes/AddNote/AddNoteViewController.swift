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
    func showChooseSourceTypeAlertController(style: UIAlertController.Style,
                                             title: String?,
                                             message: String?,
                                             animated: Bool) {
        
        showAlertPhotoPicker(style: style, title: title, message: message, animated: animated) { [ weak self ] (sourceType) in
            self?.showImagePickerController(sourceType: sourceType)
        }
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
}
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddNoteViewControllerImpl:
    UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


