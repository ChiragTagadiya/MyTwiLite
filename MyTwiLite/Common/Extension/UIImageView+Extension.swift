//
//  UIImageView+Extension.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

extension UIImageView {
    // MARK: - Set corner radius
    func setCornerRadius(_ value: CGFloat = 2.0) {
        self.layer.cornerRadius = self.frame.size.height / value
    }
}
