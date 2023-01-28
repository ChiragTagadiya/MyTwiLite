//
//  MyTwiLiteTextField.swift
//  MyTwiLite
//
//  Created by DC on 26/01/23.
//

import UIKit
import SkyFloatingLabelTextField

class MyTwiLiteTextField: SkyFloatingLabelTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureLayout()
    }
    
    // MARK: - Configure initial layout
    private func configureLayout() {
        self.titleColor = Colors.green
    }
}
