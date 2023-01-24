//
//  DashboardViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

// MARK: - Tableview Datasource & Delegate
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTimelines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: MyTwiLiteStrings.timelineTableViewCell, for: indexPath)
                as? TimelineTableViewCell else {
            return UITableViewCell()
        }
        let timeline = arrayTimelines[indexPath.row]
        cell.labelTimelineText.text = timeline?.text
        return cell
    }
}
