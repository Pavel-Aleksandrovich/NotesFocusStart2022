//
//  UIImageView Extension.swift
//  NotesFocusStart2022
//
//  Created by pavel mishanin on 04.02.2022.
//

import UIKit

extension UIImageView {
    var imageOrEmptyImage: UIImage {
        return image ?? #imageLiteral(resourceName: "DefaultProfileImage")
    }
}
