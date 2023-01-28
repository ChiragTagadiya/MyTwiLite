//
//  AddTimelineViewModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation

protocol PostTimeline {
    func postTimeline(_ uid: String, timelineText: String?, timlineImageData: Data?,
                      isReachable: ((Bool) -> Void)?, callBack: @escaping (Result<Int, Error>) -> Void)
    func deleteMyTimeline(callBack: @escaping (Result<Int, Error>) -> Void)
}

class AddTimelineViewModel: PostTimeline {
    // MARK: - Variables
    let timelinePlaceholderTitle = MyTwiLiteStrings.timelineTextPlaceholder
    let addPictureTitle = MyTwiLiteStrings.addPicture
    let validTimelineTitle = MyTwiLiteStrings.validTimeline
    let removeTimelineImageTitle = MyTwiLiteStrings.removeTimelineImageMessage
    let noInternetTitle = MyTwiLiteStrings.noInternet
    var isTextPlaceholder = true
    
    // MARK: - Set timeline text placeholder status
    func setTimelinePlaceholderStatus(_ isTextPlaceholder: Bool) {
        self.isTextPlaceholder = isTextPlaceholder
    }

    // MARK: - Validate user detail with a type
    func isTimelineValid(text: String?, imageData: Data?) -> Bool {
        let utils = Utils()
        if (!self.isTextPlaceholder && utils.isValidText(text)) || utils.isValidImage(imageData) {
            return true
        }
        return false
    }
    
    // MARK: - Post a timeline
    func postTimeline(_ uid: String, timelineText: String?, timlineImageData: Data?,
                      isReachable: ((Bool) -> Void)?, callBack: @escaping (Result<Int, Error>) -> Void) {
        if !FirebaseHelper.instance.connectedToNetwork() {
            if let isReachable = isReachable {
                isReachable(false)
            }
            return
        }

        let currentTimestamp = Utils().currentTimestamp()
        let timeline = AddTimeline(uid: uid, text: timelineText?.trimmingCharacters(in: .whitespacesAndNewlines),
                                   imageData: timlineImageData, createdDate: currentTimestamp)
        let profileImagePath = "\(MyTwiLiteKeys.profilePath)\(uid).\(MyTwiLiteKeys.jpgExtension)"
        FirebaseHelper.instance.downloadImageUrl(imagePath: profileImagePath) { result in
            switch result {
            case .success(let profileUrl):
                FirebaseHelper.instance.postTimeline(timeline: timeline,
                                                     profileUrl: profileUrl.absoluteString) { error in
                    if let error = error {
                        callBack(.failure(error))
                    } else {
                        callBack(.success(0))
                        NotificationCenter.default.post(name: Notification.Name(MyTwiLiteKeys.onAddTimelineKey), object: nil)
                    }
                }
            case .failure(let profileUrlError):
                callBack(.failure(profileUrlError))
            }
        }
    }
    
    // MARk: - Delete my timeline
    func deleteMyTimeline(callBack: @escaping (Result<Int, Error>) -> Void) {
        FirebaseHelper.instance.deleteMyTimelines { error in
            if let error = error {
                callBack(.failure(error))
            }
            callBack(.success(0))
        }
    }
}
