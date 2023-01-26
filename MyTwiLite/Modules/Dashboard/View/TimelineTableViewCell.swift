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
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTimelineImage: UIView!
    @IBOutlet weak var constraintStackViewTrailing: NSLayoutConstraint!
    
    var timeline: TimelineModel!
    var timelineDelegate: TimelineProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCellLayout()
        self.layoutIfNeeded()
        imageViewProfile.setCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Configure cell layout
    private func configureCellLayout() {
        self.viewContainer.backgroundColor = .white
        self.viewContainer.layer.cornerRadius = 10.0
        self.viewContainer.layer.shadowColor = UIColor.gray.cgColor
        self.viewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewContainer.layer.shadowRadius = 4.0
        self.viewContainer.layer.shadowOpacity = 0.5
    }

    // MARK: - Cofigure cell data
    func configureData(timeline: TimelineModel, isMyTimeline: Bool) {
        self.timeline = timeline
        self.labelTimelineText.text = timeline.text
        self.buttonDeleteTimeline.isHidden = !isMyTimeline
        self.labelTimelineText.isHidden = true
        self.viewTimelineImage.isHidden = true

        if let profilePath = timeline.profileName, !(profilePath.isEmpty) {
            let profilePlaceholderImage = UIImage(named: MyTwiLiteKeys.profilePlaceholder)
            let profileUrl = URL(string: profilePath)
            self.imageViewProfile.kf.setImage(with: profileUrl, placeholder: profilePlaceholderImage)
        }

        if let timelineText = timeline.text, !(timelineText.isEmpty) {
            self.labelTimelineText.isHidden = false
        }
        
        if let imagePath = timeline.imagePath, !(imagePath.isEmpty) {
            self.viewTimelineImage.isHidden = false
            let timelinePlaceholderImage = UIImage(named: MyTwiLiteKeys.timelinePlaceholder)
            let timelineUrl = URL(string: imagePath)
            self.imageViewTimeline.kf.setImage(with: timelineUrl, placeholder: timelinePlaceholderImage)
            
            if isMyTimeline {
                constraintStackViewTrailing.constant = 16
            } else {
                constraintStackViewTrailing.constant = 0
            }
        }
        
        self.layoutIfNeeded()
    }
    
    // MARK: - On delete timeline button press action
    @IBAction func deleteTimelineAction(_ sender: UIButton) {
        timelineDelegate?.deleteTimeline(timeline: self.timeline)
    }
}
