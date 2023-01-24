//
//  DashboardViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class DashboardViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var labelNoTimeline: UILabel!
    @IBOutlet weak var tableViewTimeline: UITableView!

    var arrayTimelines = [TimelinModel]()
    var router = DashboardRouter()
    var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = MyTwiLiteStrings.timelines
        self.shouldHideBackButton = true
        self.configureLayout()
        self.fetchTimelines()
    }

    // MARK: - Configure initial layout
    private func configureLayout() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain, target: self, action: #selector(addTimeLineAction))
        self.tableViewTimeline.tableFooterView = UIView()
        self.manageTableView(isHidden: true)
        self.labelNoTimeline.isHidden = true
        self.tableViewTimeline.estimatedRowHeight = 66
        self.tableViewTimeline.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Manageview tableview and no data label
    private func manageTableView(isHidden: Bool) {
        self.tableViewTimeline.isHidden = isHidden
        self.labelNoTimeline.isHidden = !isHidden
    }
    
    // MARK: - Fetch all timelines
    private func fetchTimelines() {
        self.showLoader()
        viewModel.fetchTimelines {[weak self] result in
            switch result {
            case .success(let timelines):
                self?.arrayTimelines = timelines
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
            
            if let timelinesData = self?.arrayTimelines, !(timelinesData.isEmpty) {
                self?.arrayTimelines = timelinesData
                self?.manageTableView(isHidden: false)
                self?.tableViewTimeline.reloadData()
            } else {
                self?.manageTableView(isHidden: true)
            }
            self?.hideLoader()
        }
    }
    
    // MARK: - Navigate to add timeline action
    private func navigateToAddTimeline() {
        router.route(to: .addTimeline, from: self, parameters: nil)
    }

    @objc func addTimeLineAction() {
        navigateToAddTimeline()
    }
}
