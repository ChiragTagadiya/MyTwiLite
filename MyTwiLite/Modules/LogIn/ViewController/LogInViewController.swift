//
//  LogInViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class LoginViewController: MyTwiLiteViewController {
    var router = LogInRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.shouldHideBackButton = true
    }
}
