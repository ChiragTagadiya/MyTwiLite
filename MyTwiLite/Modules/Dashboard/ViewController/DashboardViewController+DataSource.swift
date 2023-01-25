//
//  DashboardViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - Tableview Datasource & Delegate
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayTimelines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: MyTwiLiteKeys.timelineTableViewCell, for: indexPath)
                as? TimelineTableViewCell else {
            return UITableViewCell()
        }
        let timeline = self.viewModel.arrayTimelines[indexPath.row]
        cell.timelineDelegate = self
        cell.configureData(timeline: timeline, isMyTimeline: viewModel.isMyTimline,
                           isLastCell: indexPath.row == self.viewModel.arrayTimelines.count - 1)
        return cell
    }
}

// MARK: - Delete timeline delegate
extension DashboardViewController: TimelineProtocol {
    func deleteTimeline(timeline: TimelineModel) {
        print("delete timeline: ", timeline)
        self.showCustomAlert(message: viewModel.removeTimelineTitle) { [weak self] _ in
            self?.viewModel.deleteTimeline(timeline: timeline)
        }
    }

}
