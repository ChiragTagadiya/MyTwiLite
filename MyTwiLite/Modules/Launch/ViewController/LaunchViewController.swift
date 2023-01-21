//
//  LunchViewController.swift
//  MyTwiLite
//
//  Created by DC on 18/01/23.
//

import Foundation
import UIKit

class LaunchViewController: MyTwiLiteViewController {
    var router = LaunchRouter()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Launch Screen"
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            // TODO:  - manage redirection based on login status
            self.router.route(to: .signUp, from: self, parameters: nil)
        }
    }

}

