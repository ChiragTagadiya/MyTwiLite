//
//  MyTimelineViewController.swift
//  MyTwiLite
//
//  Created by DC on 24/01/23.
//

import UIKit

class MyTimelineViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    var viewModel = MyTimelineViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.navigationTitle
    }
}
