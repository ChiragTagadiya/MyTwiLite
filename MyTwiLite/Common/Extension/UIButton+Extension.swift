//
//  UIButton+Extension.swift
//  MyTwiLite
//
//  Created by DC on 26/01/23.
//

import Foundation
import UIKit

extension UIButton {
    // MARK: - Set corner radius
    func setCornerRadius(_ value: CGFloat = 2.0) {
        self.layer.cornerRadius = self.frame.size.height / value
    }
}
