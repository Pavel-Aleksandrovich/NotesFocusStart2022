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
        view = addNoteView
        presenter.loadView(viewController: self, view: addNoteView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNoteButton()
        title = "AddNoteViewControllerImpl"
    }
    
    private func addNoteButton() {
        let addNoteButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(showChooseSourceTypeAlertController))
        self.navigationItem.rightBarButtonItem = addNoteButton
    }
    
    @objc func showChooseSourceTypeAlertController() {
        
        showAlertPhotoPicker(style: .actionSheet, title: "title", message: nil, animated: false) { [ weak self ] (sourceType) in
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
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = editedImage.withRenderingMode(.alwaysOriginal)
            presenter.getImageFromImagePicker(image: image)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image = originalImage.withRenderingMode(.alwaysOriginal)
            presenter.getImageFromImagePicker(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}


