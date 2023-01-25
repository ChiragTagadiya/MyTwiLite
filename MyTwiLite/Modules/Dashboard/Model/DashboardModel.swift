//
//  DashboardModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation

// MARK: - Timeline structure
struct TimelineModel {
    var documentId: String
    var uid: String?
    var text: String?
    var imageName: String?
    var imagePath: String?
    var profileName: String?
    var createdDateString: String?
    var createdDate: Date
}
