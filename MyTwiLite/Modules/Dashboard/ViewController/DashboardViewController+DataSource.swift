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
        return arrayTimelines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: MyTwiLiteKeys.timelineTableViewCell, for: indexPath)
                as? TimelineTableViewCell else {
            return UITableViewCell()
        }
        let timeline = arrayTimelines[indexPath.row]
        cell.labelTimelineText.text = timeline.text
        
        if indexPath.row == arrayTimelines.count - 1 {
            cell.separatorInset.left = cell.bounds.size.width
        }
        
        if let profilePath = timeline.profileName, !(profilePath.isEmpty) {
            // TODO: - change the placeholder image
            let profilePlaceholderImage = UIImage()
            let profileUrl = URL(string: profilePath)
            cell.imageViewProfile.kf.setImage(with: profileUrl, placeholder: profilePlaceholderImage)
        }
        
        if let imagePath = timeline.imageName, !(imagePath.isEmpty) {
            // TODO: - change the placeholder image
            let timelinePlaceholderImage = UIImage()
            cell.imageViewHeightContraint.constant = 128
            let timelineUrl = URL(string: imagePath)
            cell.imageViewTimeline.kf.setImage(with: timelineUrl, placeholder: timelinePlaceholderImage)
        } else {
            cell.imageViewHeightContraint.constant = 0
        }
        cell.layoutIfNeeded()
        return cell
    }
}
