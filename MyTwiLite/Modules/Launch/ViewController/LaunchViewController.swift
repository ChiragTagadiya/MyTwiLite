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
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            // redirection based on login status
            if FirebaseHelper.instance.currentUser() != nil {
                self.router.route(to: .dashboard, from: self, parameters: nil)
            } else {
                self.router.route(to: .logIn, from: self, parameters: nil)
            }
        }
    }

}
