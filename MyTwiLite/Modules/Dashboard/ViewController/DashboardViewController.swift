//
//  DashboardViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class DashboardViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var tableViewTimeline: UITableView!

    let arrayTimeline = [String]()
    var router = DashboardRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = MyTwiLiteStrings.timelines
        self.shouldHideBackButton = true
        configureLayout()
        fetchTimelines()
    }

    // MARK: - configure initial layout
    private func configureLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: MyTwiLiteStrings.addTimeline,
                                                            style: .plain, target: self, action: #selector(addTimeLineAction))

    }
    
    // MARK: - fetch all timelines
    private func fetchTimelines() {
        
    }
    
    // MARK: - Navigate to add timeline action
    private func navigateToAddTimeline() {
        router.route(to: .addTimeline, from: self, parameters: nil)
    }

    @objc func addTimeLineAction() {
        navigateToAddTimeline()
    }
}
