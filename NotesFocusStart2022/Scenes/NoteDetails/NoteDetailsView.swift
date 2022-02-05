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

final class NoteDetailsViewImpl: UIView, NoteDetailsView, UITextFieldDelegate {
    
    private enum Constants {
        static let title = "Notes"
        static let alertTitle = "Choose Image"
    }
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let saveButton = UIButton()
    private let noteImageView = UIImageView()
    private let scrollView = UIScrollView()
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
    
    private func configureView() {
        
        self.backgroundColor = .white
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 25
        saveButton.backgroundColor = .red
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        titleTextField.layer.borderWidth = 0.5
        titleTextField.layer.cornerRadius = 5
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.delegate = self
        titleTextField.placeholder = "Entry text"
        titleTextField.textAlignment = .left
        
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        noteImageView.image = #imageLiteral(resourceName: "DefaultProfileImage")
        noteImageView.layer.cornerRadius = 25
        noteImageView.clipsToBounds = true
        
        [titleTextField, saveButton, noteImageView, scrollView, descriptionTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(scrollView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(descriptionTextView)
        addSubview(saveButton)
        addSubview(noteImageView)
        
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
            
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: noteImageView.topAnchor, constant: -10),
            
            titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
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
            
            scrollView.leadingAnchor.constraint(equalTo: noteImageView.trailingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            
            titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
        
        ])
        
        NSLayoutConstraint.activate( hConstraints )
        
        changeViewLayout(traitCollection: traitCollection)
    }
    
    
}
