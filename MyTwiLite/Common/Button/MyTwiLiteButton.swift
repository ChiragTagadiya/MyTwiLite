//
//  MyTwiLiteButton.swift
//  MyTwiLite
//
//  Created by DC on 26/01/23.
//

import UIKit

class MyTwiLiteButton: UIButton {
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
        self.tintColor = Colors.green
    }
    
    func setFilledLayout(_ color: UIColor = Colors.green) {
        self.backgroundColor = color
        self.tintColor = Colors.white
        self.layer.cornerRadius = 4
    }
}
