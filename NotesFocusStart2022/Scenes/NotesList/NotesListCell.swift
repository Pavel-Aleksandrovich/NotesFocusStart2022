//
//  NotesListCell.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NotesListCell: UITableViewCell {
    
    private let noteImageView = UIImageView()
    private let noteTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(note: NoteEntity) {
        noteTitle.text = note.title
        noteImageView.image = note.noteImage
    }
    
}

// MARK: - Configure View

private extension NotesListCell {
    
    func configureView() {
        
        
        noteImageView.translatesAutoresizingMaskIntoConstraints = false
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(noteImageView)
        addSubview(noteTitle)
    }
    
    func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            noteImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            noteImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noteImageView.widthAnchor.constraint(equalToConstant: self.bounds.height),
            noteImageView.heightAnchor.constraint(equalToConstant: self.bounds.height),
            
            noteTitle.leadingAnchor.constraint(equalTo: noteImageView.trailingAnchor),
            noteTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noteTitle.heightAnchor.constraint(equalToConstant: 30),
            noteTitle.widthAnchor.constraint(equalToConstant: self.bounds.width/2)
        ])
        
    }
}
