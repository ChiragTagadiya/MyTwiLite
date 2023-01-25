//
//  TimelineTableViewCell.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    // MARK: - Outlets & Variables
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelTimelineText: UILabel!
    @IBOutlet weak var imageViewTimeline: UIImageView!

    @IBOutlet weak var imageViewHeightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewHeightContraint.constant = 0
        self.layoutIfNeeded()
        imageViewProfile.setCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Cofigure cell data
    func configureData(timeline: TimelineModel, isLastCell: Bool) {
        self.labelTimelineText.text = timeline.text
        if let profilePath = timeline.profileName, !(profilePath.isEmpty) {
            let profilePlaceholderImage = UIImage(named: MyTwiLiteKeys.profilePlaceholder)
            let profileUrl = URL(string: profilePath)
            self.imageViewProfile.kf.setImage(with: profileUrl, placeholder: profilePlaceholderImage)
        }
        
        if let imagePath = timeline.imageName, !(imagePath.isEmpty) {
            let timelinePlaceholderImage = UIImage(named: MyTwiLiteKeys.timelinePlaceholder)
            self.imageViewHeightContraint.constant = 128
            let timelineUrl = URL(string: imagePath)
            self.imageViewTimeline.kf.setImage(with: timelineUrl, placeholder: timelinePlaceholderImage)
        } else {
            self.imageViewHeightContraint.constant = 0
        }
        
        if isLastCell {
            self.separatorInset.left = self.bounds.size.width
        }
        
        self.layoutIfNeeded()
    }
}
