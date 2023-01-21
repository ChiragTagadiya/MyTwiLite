//
//  MyTwiLiteViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class MyTwiLiteViewController: UIViewController {
    var shouldHideBackButton: Bool = false {
        didSet {
            self.navigationItem.hidesBackButton = shouldHideBackButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
