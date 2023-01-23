//
//  AddTimelineViewModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation

class AddTimelineViewModel {
    // MARK: - Validate user detail with a type
    func isTimelineValid(text: String?, imageData: Data?) -> Bool {
        let utils = Utils()
        if utils.isValidText(text) || utils.isValidImage(imageData) {
            return true
        }
        return false
    }
    
    // MARK: - Post a timeline
    func postTimeline(_ uid: String, timelineText: String?,
                      timlineImageData: Data?, callBack: @escaping (Result<Int, Error>) -> Void) {
        let currentTimestamp = Utils().currentTimestamp()
        let timeline = AddTimeline(uid: uid, text: timelineText,
                                   imageData: timlineImageData, createdDate: currentTimestamp)
        FirebaseHelper.instance.postTimeline(timeline: timeline) { error in
            if let error = error {
                callBack(.failure(error))
            } else {
                callBack(.success(0))
            }
        }
    }
}
