//
//  ProfileViewController.swift
//  MyTwiLite
//
//  Created by DC on 24/01/23.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Variables & Outlets
    let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.navigationTitle
    }

}
