//
//  UIViewController Extension.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 04.02.2022.
//

import UIKit

extension UIViewController {
    
    // MARK: - Alert for pick photo from gallery or camera
    
    func showAlertPhotoPicker(style: UIAlertController.Style, title: String?, message: String?, animated: Bool,
                              closure: @escaping (UIImagePickerController.SourceType) -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let photoLibraryAction = UIAlertAction(title: "Library", style: .default) {_ in
            closure(.photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {_ in
//            closure(.camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: animated)
    }
}
