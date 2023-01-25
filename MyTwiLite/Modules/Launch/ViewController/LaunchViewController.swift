//
//  LunchViewController.swift
//  MyTwiLite
//
//  Created by DC on 18/01/23.
//

import Foundation
import UIKit

class LaunchViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    var router = LaunchRouter()
    var viewModel = LaunchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel.navigationTitle
        self.manageLaunchRouter()
    }

    // MARK: - Handle launch router based on login status
    func manageLaunchRouter() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            // redirection based on login status
            if self.viewModel.isUserLogin() {
                self.router.route(to: .dashboard, from: self, parameters: nil)
            } else {
                self.router.route(to: .logIn, from: self, parameters: nil)
            }
        }
    }
}
