//
//  MyTwiLiteStrings.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

// MARK: - Texts to present on screen
struct MyTwiLiteStrings {
    static let launchScreen = "Launch Screen"
    static let signUp = "Sign Up"
    static let validFirstName = "INVALID FIRST NAME"
    static let validLastName = "INVALID LAST NAME"
    static let validEmail = "INVALID EMAIL"
    static let validPassword = "INVALID PASSWORD"
    static let validConfirmPassword = "INVALID CONFIRM PASSWORD"
    static let logIn = "Log In"
    static let okTitle = "Ok"
    static let yesTitle = "Yes"
    static let noTitle = "No"
    static let timelines = "Timelines"
    static let removeTimelineImageMessage = "Are you sure to remove a timeline picture ?"
    static let validTimeline = "Please enter atleast a valid text or select a picture to post a timeline."
    static let timelineTextPlaceholder = "Add Timeline..."
    static let addPicture = "Add Picture"
    static let myTimeline = "My Timeline"
    static let profile = "Profile"
    static let removeTimeline = "Are you sure to delete this timeline ?"
}

// MARK: - Keys to use inside the app
struct MyTwiLiteKeys {
    static let profilePath = "profiles/"
    static let timelinePath = "timelines/"
    static let jpgExtension = "jpg"
    static let uidKey = "uid"
    static let firstNameKey = "first_name"
    static let lastNameKey = "last_name"
    static let profileImagePathKey = "profile_image_path"
    static let timelineTextKey = "timeline_text"
    static let timelineImagePathKey = "timeline_image_path"
    static let timelineImageNameKey = "timeline_image_name"
    static let createdDateKey = "created_date"
    static let usersKey = "users"
    static let timelinesKey = "timelines"
    static let normalDateFormat = "h:mm a, d MMM, yyyy"
    static let timelineTableViewCell = "TimelineTableViewCell"
    static let dashBoardIcon = "DashboardIcon"
    static let myTimelineIcon = "MyTimeline"
    static let profileIcon = "ProfileIcon"
    static let profilePlaceholder = "ProfilePlaceholder"
    static let timelinePlaceholder = "TimelinePlaceholder"
    static let isLoginKey = "isLogin"
    static let onAddTimelineKey = "onAddTimeline"
    static let editIconKey = "square.and.pencil"
}
