//
//  AddNoteView.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol NoteDetailsView: UIView {
    var saveButtonTappedHandler: ((NoteEntity) -> ())? { get set }
    func configure(note: NoteEntity)
    func getImageFromImagePicker(image: UIImage)
}

final class NoteDetailsViewImpl: UIView, NoteDetailsView {
    
    private enum Constants {
        static let saveButtonTitle = "SAVE"
        static let saveButtonCornerRadius: CGFloat = 25
        
        static let titleBorderWidth: CGFloat = 0.5
        static let titleCornerRadius: CGFloat = 5
        static let titlePlaceholder = "Entry text"
        
        static let descriptionBorderWidth: CGFloat = 0.5
        static let descriptionCornerRadius: CGFloat = 5
        
        static let imageCornerRadius: CGFloat = 25
    }
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let saveButton = UIButton()
    private let noteImageView = UIImageView()
    private var vConstraints = [NSLayoutConstraint]()
    private var hConstraints = [NSLayoutConstraint]()
    
    var saveButtonTappedHandler: ((NoteEntity) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImageFromImagePicker(image: UIImage) {
        noteImageView.image = image
    }
    
    func configure(note: NoteEntity) {
        titleTextField.text = note.title
        descriptionTextView.text = note.descriptionText
        noteImageView.image = note.noteImage
    }
    
    @objc func saveButtonTapped() {
        let note = NoteEntity(title: titleTextField.textOrEmptyString,
                              descriptionText: descriptionTextView.textOrEmptyString,
                              noteImage: noteImageView.imageOrEmptyImage)
        self.saveButtonTappedHandler?(note)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        changeViewLayout(traitCollection: traitCollection, previousTraitCollection: previousTraitCollection)
    }
    
    private func changeViewLayout(traitCollection: UITraitCollection, previousTraitCollection: UITraitCollection? = nil) {
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
                traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass else { return }
        
        switch(traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular): activateCompactLayout()
        default:                   activateRegularLayout()
        }
    }
    
    private func activateCompactLayout() {
        NSLayoutConstraint.deactivate(hConstraints)
        NSLayoutConstraint.activate(vConstraints)
    }
    
    private func activateRegularLayout() {
        NSLayoutConstraint.deactivate(vConstraints)
        NSLayoutConstraint.activate(hConstraints)
    }
    
    private func configureView() {
        
        self.backgroundColor = .white
        
        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = Constants.saveButtonCornerRadius
        saveButton.backgroundColor = .red
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        titleTextField.layer.borderWidth = Constants.titleBorderWidth
        titleTextField.layer.cornerRadius = Constants.titleCornerRadius
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.placeholder = Constants.titlePlaceholder
        titleTextField.textAlignment = .left
        
        descriptionTextView.layer.borderWidth = Constants.descriptionBorderWidth
        descriptionTextView.layer.cornerRadius = Constants.descriptionCornerRadius
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        noteImageView.image = #imageLiteral(resourceName: "DefaultProfileImage")
        noteImageView.layer.cornerRadius = Constants.imageCornerRadius
        noteImageView.clipsToBounds = true
        
        [titleTextField, saveButton, noteImageView, descriptionTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(titleTextField)
        addSubview(descriptionTextView)
        addSubview(saveButton)
        addSubview(noteImageView)
        
    }
    
    private func configureLayoutConstraints() {
        
        vConstraints.append(contentsOf: [
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            saveButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            noteImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noteImageView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            noteImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            noteImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            
            titleTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            descriptionTextView.bottomAnchor.constraint(equalTo: noteImageView.topAnchor, constant: -10),
        ])
        
        hConstraints.append(contentsOf: [
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            saveButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            noteImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            noteImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noteImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            noteImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            
            titleTextField.leadingAnchor.constraint(equalTo: noteImageView.trailingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: noteImageView.trailingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
        
        ])
        NSLayoutConstraint.activate( hConstraints )
        changeViewLayout(traitCollection: traitCollection)
    }
}

