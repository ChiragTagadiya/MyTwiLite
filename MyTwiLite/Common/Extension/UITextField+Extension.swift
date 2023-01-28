//
//  UITextField+Extension.swift
//  MyTwiLite
//
//  Created by DC on 27/01/23.
//

import Foundation
import UIKit

extension UITextView {
    // MARK: - Set corner radius
    func setCornerRadius() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Colors.lightGray.cgColor
        self.layer.cornerRadius = 6
    }
}
