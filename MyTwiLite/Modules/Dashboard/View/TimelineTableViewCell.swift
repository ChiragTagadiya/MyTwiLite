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
    @IBOutlet weak var imageBGView: UIView!

    var timeline: TimelineModel!
    var timelineDelegate: TimelineProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        self.labelTimelineText.isHidden = true
        self.imageBGView.isHidden = true

        if let profilePath = timeline.profileName, !(profilePath.isEmpty) {
            let profilePlaceholderImage = UIImage(named: MyTwiLiteKeys.profilePlaceholder)
            let profileUrl = URL(string: profilePath)
            self.imageViewProfile.kf.setImage(with: profileUrl, placeholder: profilePlaceholderImage)
        }

        if let timelineText = timeline.text, !(timelineText.isEmpty) {
            self.labelTimelineText.isHidden = false
        }
        
        if let imagePath = timeline.imagePath, !(imagePath.isEmpty) {
            self.imageBGView.isHidden = false
            let timelinePlaceholderImage = UIImage(named: MyTwiLiteKeys.timelinePlaceholder)
            let timelineUrl = URL(string: imagePath)
            self.imageViewTimeline.kf.setImage(with: timelineUrl, placeholder: timelinePlaceholderImage)
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
