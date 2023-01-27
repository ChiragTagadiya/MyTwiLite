//
//  DashboardViewModel.swift
//  MyTwiLite
//
//  Created by DC on 23/01/23.
//

import Foundation
import Firebase

protocol DeleteTimelineProtocol {
    func onDeleteTimeline()
}

class DashboardViewModel {
    // MARK: - Variables
    var isMyTimline = false
    let removeTimelineTitle = MyTwiLiteStrings.removeTimeline
    let noInternetTitle = MyTwiLiteStrings.noInternet
    var arrayTimelines = [TimelineModel]()
    var deleteTimelineDelegate: DeleteTimelineProtocol?
    
    // MARK: - Get navigation title
    func navigationTitle() -> String {
        return self.isMyTimline ? MyTwiLiteStrings.myTimeline : MyTwiLiteStrings.timelines
    }
    
    // MARK: - Prepare timeline data
    private func prepareTimelineData(snapshot: QuerySnapshot?, callBack: @escaping (Result<Int, Error>) -> Void) {
        var timelines = [TimelineModel]()
        if let snapshot = snapshot {
            for document in snapshot.documents {
                let timelineData = document.data()
                var timelineModel = TimelineModel(documentId: document.documentID, createdDate: Date())
                timelineModel.uid = timelineData[MyTwiLiteKeys.uidKey] as? String
                timelineModel.text = timelineData[MyTwiLiteKeys.timelineTextKey] as? String
                timelineModel.imagePath = timelineData[MyTwiLiteKeys.timelineImagePathKey] as? String
                timelineModel.imageName = timelineData[MyTwiLiteKeys.timelineImageNameKey] as? String
                timelineModel.profileName = timelineData[MyTwiLiteKeys.profileImagePathKey] as? String
                let createdDate = timelineData[MyTwiLiteKeys.createdDateKey] as? String
                timelineModel.createdDate = Utils().convertTimespampToDate(timestamp: createdDate)
                timelineModel.createdDateString = Utils().convertTimespampToDateString(timestamp: createdDate)
                timelines.append(timelineModel)
            }
            timelines = timelines.sorted(by: { $0.createdDate.compare($1.createdDate) == .orderedDescending })
        }
        self.arrayTimelines = timelines
        callBack(.success(0))
    }
    
    // MARK: - Fetch my timelines
    func fetchMyTimelines(callBack: @escaping (Result<Int, Error>) -> Void) {
        FirebaseHelper.instance.fetchMyTimelines { [weak self] snapshot, error in
            if let error = error {
                callBack(.failure(error))
            } else {
                self?.prepareTimelineData(snapshot: snapshot, callBack: callBack)
            }
        }
    }
    
    // MARK: - Fetch all timelines
    func fetchAllTimeLines(callBack: @escaping (Result<Int, Error>) -> Void) {
        FirebaseHelper.instance.fetchTimelines { [weak self] snapshot, error in
            if let error = error {
                callBack(.failure(error))
            } else {
                self?.prepareTimelineData(snapshot: snapshot, callBack: callBack)
            }
        }
    }
    
    // MARK: - Fetch timelines
    func fetchTimelines(callBack: @escaping (Result<Int, Error>) -> Void) {
        if self.isMyTimline {
            self.fetchMyTimelines(callBack: callBack)
        } else {
            self.fetchAllTimeLines(callBack: callBack)
        }
    }
    
    // MARK: - Delete timeline
    func deleteTimeline(timeline: TimelineModel, isReachable: @escaping ((Bool) -> Void), callBack: @escaping ((Error?) -> Void)) {
        FirebaseHelper.instance.deleteTimeline(timeline: timeline, isReachable: isReachable, callBack: callBack)
    }
    
    // MARK: - Cheeck network status
    func connectedToNetwork() -> Bool {
        return FirebaseHelper.instance.connectedToNetwork()
    }
}
