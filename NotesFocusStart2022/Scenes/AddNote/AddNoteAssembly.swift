//
//  AddNoteAssembly.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 31.01.2022.
//

import UIKit

final class AddNoteAssembly {
    
    static func build() -> UIViewController {
        
        let viewController = AddNoteViewControllerImpl()
        
        return viewController
    }
}
