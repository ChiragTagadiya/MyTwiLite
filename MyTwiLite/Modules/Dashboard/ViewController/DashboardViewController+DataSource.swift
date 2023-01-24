//
//  DashboardViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit
import SDWebImage

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
        
        if let uid = timeline.uid, !(uid.isEmpty) {
            // TODO: - change the placeholder image
            let profilePlaceholderImage = UIImage()
            cell.imageViewProfile.image = profilePlaceholderImage
            let profileImagePath = "\(MyTwiLiteKeys.profilePath)\(uid).\(MyTwiLiteKeys.jpgExtension)"
            
            viewModel.downloadImageUrl(imagePath: profileImagePath) { result in
                switch result {
                case .success(let url):
                    cell.imageViewProfile.sd_setImage(with: url, placeholderImage: profilePlaceholderImage)
                case .failure(let error):
                    debugPrint("error while download profile image url: ", error.localizedDescription)
                }
            }
        }
        
        if let imagePath = timeline.imageName, !(imagePath.isEmpty) {
            // TODO: - change the placeholder image
            let timelinePlaceholderImage = UIImage()
            cell.imageViewTimeline.image = timelinePlaceholderImage
            cell.imageViewHeightContraint.constant = 128
            viewModel.downloadImageUrl(imagePath: imagePath) { result in
                switch result {
                case .success(let url):
                    cell.imageViewTimeline.sd_setImage(with: url, placeholderImage: timelinePlaceholderImage)
                case .failure(let error):
                    debugPrint("error while download timeline image url: ", error.localizedDescription)
                }
            }
        } else {
            cell.imageViewHeightContraint.constant = 0
        }
        cell.layoutIfNeeded()
        return cell
    }
}
