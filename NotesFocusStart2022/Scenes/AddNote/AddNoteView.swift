//
//  AddNoteView.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

protocol AddNoteView: UIView {
    var saveButtonTappedHandler: ((NoteEntity) -> ())? { get set }
    func configure(note: NoteEntity)
}

final class AddNoteViewImpl: UIView, AddNoteView, UITextFieldDelegate {
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let saveButton = UIButton()
    private let noteImageView = UIImageView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
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
    
    func configureView() {
        
        self.backgroundColor = .white
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 25
        saveButton.backgroundColor = .red
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        titleTextField.backgroundColor = .red
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.delegate = self
        titleTextField.placeholder = "Entry text"
        titleTextField.textAlignment = .left
        
        descriptionTextView.backgroundColor = .red
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        
        noteImageView.backgroundColor = .gray
        noteImageView.layer.cornerRadius = 25
        noteImageView.clipsToBounds = true
        
        contentView.backgroundColor = .white
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        noteImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(descriptionTextView)
        addSubview(saveButton)
        addSubview(noteImageView)
        
    }
    
    func configure(note: NoteEntity) {
        titleTextField.text = note.title
        descriptionTextView.text = note.descriptionText
    }
    
    @objc func saveButtonTapped() {
        let note = NoteEntity(title: titleTextField.text ?? "nil", descriptionText: descriptionTextView.text ?? "nil")
        self.saveButtonTappedHandler?(note)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        changeViewLayout(traitCollection: traitCollection, previousTraitCollection: previousTraitCollection)
    }
    
    func changeViewLayout(traitCollection: UITraitCollection, previousTraitCollection: UITraitCollection? = nil) {
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
                traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass else { return }
        
        switch(traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular): activateCompactLayout()
        default:                   activateRegularLayout()
        }
    }
    
    func activateCompactLayout() {
        NSLayoutConstraint.deactivate(hConstraints)
        NSLayoutConstraint.activate(vConstraints)
    }
    
    func activateRegularLayout() {
        NSLayoutConstraint.deactivate(vConstraints)
        NSLayoutConstraint.activate(hConstraints)
    }
    
    func configureLayoutConstraints() {
        
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
            noteImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            noteImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
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

extension AddNoteViewImpl {
    func imagePicker(info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.noteImageView.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.noteImageView.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        
    }
}



