//
//  UserProfileModel.swift
//  MyTwiLite
//
//  Created by DC on 27/01/23.
//

import Foundation

// MARK: - Timeline structure
struct UserProfileModel {
    var documentId: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var profilePath: URL
}
