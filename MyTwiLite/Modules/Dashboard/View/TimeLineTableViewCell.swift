//
//  TimeLineTableViewCell.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelTimelineText: UILabel!
    @IBOutlet weak var imageViewTimeline: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
