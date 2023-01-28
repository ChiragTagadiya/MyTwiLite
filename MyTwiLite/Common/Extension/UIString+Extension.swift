//
//  UIString+Extension.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

extension String {
    // MARK: - Function to set first letter capital
    var capitalizedFirstLetter: String {
        self.prefix(1).uppercased() + self.dropFirst()
    }
}
