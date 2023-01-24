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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewProfile.setCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
