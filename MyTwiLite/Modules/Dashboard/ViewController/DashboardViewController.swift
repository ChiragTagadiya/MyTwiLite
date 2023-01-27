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

    let refreshControl = UIRefreshControl()
    var router = DashboardRouter()
    var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.navigationTitle()
        self.configureLayout()
        self.fetchTimelines()
        self.setNotificationObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNotificationObserver()
    }
    
    // MARK: - Set add timeline notification observer
    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onAddTimeline),
                                               name: Notification.Name(MyTwiLiteKeys.onAddTimelineKey),
                                               object: nil)
    }
    
    // MARK: - Remove add timeline notification observer
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(Notification.Name(MyTwiLiteKeys.onAddTimelineKey))
    }

    // MARK: - On add timeline notification receiver
    @objc func onAddTimeline() {
        self.fetchTimelines()
    }
    
    // MARK: - Configure initial layout
    private func configureLayout() {
        self.shouldHideBackButton = true
        let barButtonItem = UIBarButtonItem(image: .add,
                                            style: .plain, target: self, action: #selector(addTimeLineAction))
        barButtonItem.tintColor = Colors.green
        navigationItem.rightBarButtonItem = barButtonItem
        self.tableViewTimeline.tableFooterView = UIView()
        self.manageTableView(isHidden: true)
        self.labelNoTimeline.isHidden = true
        self.tableViewTimeline.estimatedRowHeight = 90
        self.tableViewTimeline.rowHeight = UITableView.automaticDimension
        refreshControl.addTarget(self, action: #selector(self.pnPullToRefreshAction(_:)), for: .valueChanged)
        self.tableViewTimeline.addSubview(refreshControl)
    }
    
    // MARK: - On pull to refresh action
    @objc func pnPullToRefreshAction(_ sender: AnyObject) {
        self.fetchTimelines()
    }
    
    // MARK: - Manageview tableview and no data label
    private func manageTableView(isHidden: Bool) {
        self.tableViewTimeline.isHidden = isHidden
        self.labelNoTimeline.isHidden = !isHidden
    }
    
    // MARK: - Fetch all timelines
    func fetchTimelines() {
        self.showLoader()
        self.viewModel.fetchTimelines {[weak self] result in
            self?.refreshControl.endRefreshing()
            switch result {
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            default:
                break
            }
            
            if let timelinesData = self?.viewModel.arrayTimelines, !(timelinesData.isEmpty) {
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
