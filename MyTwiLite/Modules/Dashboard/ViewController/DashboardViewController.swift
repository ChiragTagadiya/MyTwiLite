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
//        if let addTimelineViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddTimelineViewController") as? AddTimelineViewController {
//            self.navigationController?.pushViewController(addTimelineViewController, animated: true)
//        }
    }

    @objc func addTimeLineAction() {
        navigateToAddTimeline()
    }
}
