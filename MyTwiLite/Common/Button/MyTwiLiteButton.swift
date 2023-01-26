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
        configureLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayout()
    }
    
    // MARK: - Configure initial layout
    func configureLayout() {
        self.tintColor = Colors.green
    }
    
    func setFilledLayout() {
        self.backgroundColor = Colors.green
        self.tintColor = Colors.white
        self.layer.cornerRadius = 4
    }
}
