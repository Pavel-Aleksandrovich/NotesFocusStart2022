//
//  NoteDetailsViewController.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NoteDetailsViewController: AnyObject {
    
}

final class NoteDetailsViewControllerImpl: UIViewController, NoteDetailsViewController {
    
    private enum Constants {
        static let title = "Notes"
        static let alertTitle = "Choose Image"
    }
    
    private let noteDetailsView: NoteDetailsView
    private let presenter: NoteDetailsPresenter
    
    init(presenter: NoteDetailsPresenter) {
        self.presenter = presenter
        noteDetailsView = NoteDetailsViewImpl()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = noteDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadView(viewController: self, view: noteDetailsView)
        createAddPickImageButton()
        title = Constants.title
    }
    
    private func createAddPickImageButton() {
        let addPickImageButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(showChooseSourceTypeAlertController))
        self.navigationItem.rightBarButtonItem = addPickImageButton
    }
    
    @objc func showChooseSourceTypeAlertController() {
        
        showAlertPhotoPicker(style: .actionSheet, title: Constants.alertTitle, message: nil, animated: false) { [ weak self ] (sourceType) in
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

extension NoteDetailsViewControllerImpl:
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


