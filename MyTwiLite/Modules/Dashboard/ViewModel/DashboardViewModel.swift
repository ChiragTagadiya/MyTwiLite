//
//  DashboardViewModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation

class DashboardViewModel {
    // MARK: - Download image url
    func downloadImageUrl(imagePath: String, callback: @escaping (Result<URL, Error>) -> Void) {
        FirebaseHelper.instance.downloadImageUrl(imagePath: imagePath) { result in
            callback(result)
        }
    }
    
    // MARK: - Fetch timelines
    func fetchTimelines(callBack: @escaping (Result<[TimelinModel], Error>) -> Void) {
        FirebaseHelper.instance.fetchTimelines { snapshot, error in
            if let error = error {
                callBack(.failure(error))
            } else {
                var timelines = [TimelinModel]()
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let timelineData = document.data()
                        var timelineModel = TimelinModel()
                        timelineModel.uid = timelineData[MyTwiLiteKeys.uidKey] as? String
                        timelineModel.text = timelineData[MyTwiLiteKeys.timelineTextKey] as? String
                        timelineModel.imageName = timelineData[MyTwiLiteKeys.timelineImagePathKey] as? String
                        timelineModel.profileName = timelineData[MyTwiLiteKeys.profileImagePathKey] as? String
                        let createdDate = timelineData[MyTwiLiteKeys.createdDateKey] as? String
                        timelineModel.createdDate = Utils().convertTimespampToDate(timestamp: createdDate)
                        timelines.append(timelineModel)
                    }
                    // TODO: - sort timelines by created_date
                }
                callBack(.success(timelines))
            }
        }
    }
}
