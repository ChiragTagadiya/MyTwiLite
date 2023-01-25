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
        cell.configureData(timeline: timeline,
                           isLastCell: indexPath.row == self.viewModel.arrayTimelines.count - 1)
        return cell
    }
}
