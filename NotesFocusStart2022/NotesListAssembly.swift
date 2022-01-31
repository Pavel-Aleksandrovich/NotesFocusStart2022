//
//  NotesListAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NotesListAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = NotesListTableAdapter()
        let presenter = NotesListPresenterImpl()
        let viewController = NotesListViewControllerImpl(presenter: presenter)
        return UINavigationController(rootViewController: viewController)
    }
}
