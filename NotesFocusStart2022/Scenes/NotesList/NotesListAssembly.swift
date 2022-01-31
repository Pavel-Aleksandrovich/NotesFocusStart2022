//
//  NotesListAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class NotesListAssembly {
    
    static func build() -> UIViewController {
        
        let router = NotesListRouterImpl()
        let tableAdapter = NotesListTableAdapterImpl()
        let presenter = NotesListPresenterImpl(tableAdapter: tableAdapter, router: router)
        let viewController = NotesListViewControllerImpl(presenter: presenter)
        
        return viewController
    }
}
