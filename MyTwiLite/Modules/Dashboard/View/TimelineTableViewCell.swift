//
//  TimelineTableViewCell.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

protocol TimelineProtocol {
    func deleteTimeline(timeline: TimelineModel)
}

class TimelineTableViewCell: UITableViewCell {
    // MARK: - Variables & Outlets
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelTimelineText: UILabel!
    @IBOutlet weak var imageViewTimeline: UIImageView!
    @IBOutlet weak var buttonDeleteTimeline: UIButton!
    
    @IBOutlet weak var imageViewHeightContraint: NSLayoutConstraint!
    
    var timeline: TimelineModel!
    var timelineDelegate: TimelineProtocol?
    
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
    func configureData(timeline: TimelineModel, isMyTimeline: Bool, isLastCell: Bool) {
        self.timeline = timeline
        self.labelTimelineText.text = timeline.text
        self.buttonDeleteTimeline.isHidden = !isMyTimeline

        if let profilePath = timeline.profileName, !(profilePath.isEmpty) {
            let profilePlaceholderImage = UIImage(named: MyTwiLiteKeys.profilePlaceholder)
            let profileUrl = URL(string: profilePath)
            self.imageViewProfile.kf.setImage(with: profileUrl, placeholder: profilePlaceholderImage)
        }
        
        if let imagePath = timeline.imagePath, !(imagePath.isEmpty) {
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
    
    // MARK: - On delete timeline button press action
    @IBAction func deleteTimelineAction(_ sender: UIButton) {
        timelineDelegate?.deleteTimeline(timeline: self.timeline)
    }
}
