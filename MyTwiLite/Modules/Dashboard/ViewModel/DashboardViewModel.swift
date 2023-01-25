//
//  DashboardViewModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation

class DashboardViewModel {
    // MARK: - Variables
    let navigationTitle = MyTwiLiteStrings.timelines
    var arrayTimelines = [TimelineModel]()


    // MARK: - Download image url
    func downloadImageUrl(imagePath: String, callback: @escaping (Result<URL, Error>) -> Void) {
        FirebaseHelper.instance.downloadImageUrl(imagePath: imagePath) { result in
            callback(result)
        }
    }
    
    // MARK: - Fetch timelines
    func fetchTimelines(callBack: @escaping (Result<Int, Error>) -> Void) {
        FirebaseHelper.instance.fetchTimelines { [weak self] snapshot, error in
            if let error = error {
                callBack(.failure(error))
            } else {
                var timelines = [TimelineModel]()
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let timelineData = document.data()
                        var timelineModel = TimelineModel(createdDate: Date())
                        timelineModel.uid = timelineData[MyTwiLiteKeys.uidKey] as? String
                        timelineModel.text = timelineData[MyTwiLiteKeys.timelineTextKey] as? String
                        timelineModel.imageName = timelineData[MyTwiLiteKeys.timelineImagePathKey] as? String
                        timelineModel.profileName = timelineData[MyTwiLiteKeys.profileImagePathKey] as? String
                        let createdDate = timelineData[MyTwiLiteKeys.createdDateKey] as? String
                        timelineModel.createdDate = Utils().convertTimespampToDate(timestamp: createdDate)
                        timelineModel.createdDateString = Utils().convertTimespampToDateString(timestamp: createdDate)
                        timelines.append(timelineModel)
                    }
                    timelines = timelines.sorted(by: { $0.createdDate.compare($1.createdDate) == .orderedDescending })
                }
                self?.arrayTimelines = timelines
                callBack(.success(0))
            }
        }
    }
}
