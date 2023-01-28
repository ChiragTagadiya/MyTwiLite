//
//  FirebaseHelper.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SystemConfiguration

class FirebaseHelper {
    static let instance = FirebaseHelper()
    
    // MARK: - Fetch current user
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - SignUp user
    func createUser(user: UserDetail, isReachable: @escaping ((Bool) -> Void), callBack: @escaping FirebaseCallBackType) {
        if !FirebaseHelper.instance.connectedToNetwork() {
            isReachable(false)
            return
        }
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] (result, error) in
            if let uid = result?.user.uid {
                self?.uploadProfilePicture(path: MyTwiLiteKeys.profilePath, uid: uid,
                                          imageData: user.profileImageData, currentTimestemp: nil) { imagePath, uploadProfilePictureError in
                    if uploadProfilePictureError != nil {
                        callBack(nil, uploadProfilePictureError)
                    } else {
                        if let imagePath = imagePath {
                            self?.addUserInformaion(uid: uid, profilePicturePath: imagePath, user: user) { userInformationError in
                                if let userInformationError = userInformationError {
                                    callBack(nil, userInformationError)
                                } else {
                                    callBack(result, error)
                                }
                            }
                        } else {
                            callBack(nil, error)
                        }
                    }
                }
            } else {
                callBack(nil, error)
            }
        }
    }
    
    // MARK: - Log in user
    func logInUser(email: String, password: String,
                   isReachable: ((Bool) -> Void)?,
                   callBack: @escaping FirebaseCallBackType) {
        if !FirebaseHelper.instance.connectedToNetwork() {
            if let isReachable = isReachable {
                isReachable(false)
            }
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if result != nil {
                Utils().setLoginStatus(isLogin: true)
            }
            callBack(result, error)
        }
    }
    
    // MARK: - Log out user
    func logOut(isReachable: @escaping ((Bool) -> Void), callback: @escaping (Result<Int, Error>) -> Void) {
        if !FirebaseHelper.instance.connectedToNetwork() {
            isReachable(false)
            return
        }
        do {
            try Auth.auth().signOut()
            Utils().setLoginStatus(isLogin: false)
            callback(.success(0))
        } catch {
            callback(.failure(error))
        }
    }
    
    // MARK: - Add user information to firestore
    func addUserInformaion(uid: String, profilePicturePath: String, user: UserDetail, callBack: @escaping (Error?) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        let userInformation = [
            MyTwiLiteKeys.uidKey: uid,
            MyTwiLiteKeys.firstNameKey: user.firstName,
            MyTwiLiteKeys.lastNameKey: user.lastName,
            MyTwiLiteKeys.profileImagePathKey: profilePicturePath
        ]
        fireStoreDatabase.collection(MyTwiLiteKeys.usersKey).addDocument(data: userInformation) { error in
            callBack(error)
        }
    }
    
    // MARK: - Upload a user profile picture
    func uploadProfilePicture(path: String, uid: String, imageData: Data,
                              currentTimestemp: String?, callBack: @escaping (String?, Error?) -> Void) {
        let storageReference = Storage.storage().reference()
        var filePath = "\(path)\(uid).\(MyTwiLiteKeys.jpgExtension)"
        if let currentTimestemp = currentTimestemp {
            filePath = "\(path)\(uid)_\(currentTimestemp).\(MyTwiLiteKeys.jpgExtension)"
        }
        let fileReference = storageReference.child(filePath)
        _ = fileReference.putData(imageData) { storageMetaData, error in
            if error != nil {
                callBack(nil, error)
            }
            if storageMetaData != nil {
                callBack(filePath, nil)
            }
        }
    }
    
    // MARK: - Add timeline information to firestore
    func addTimelineInformaion(timeline: AddTimeline,
                               text: String,
                               timelinePicturePath: String,
                               timelineImagePath: String,
                               profileUrl: String,
                               callBack: @escaping (Error?) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        let timelineInformation = [
            MyTwiLiteKeys.uidKey: timeline.uid,
            MyTwiLiteKeys.timelineTextKey: text,
            MyTwiLiteKeys.timelineImagePathKey: timelinePicturePath,
            MyTwiLiteKeys.createdDateKey: timeline.createdDate,
            MyTwiLiteKeys.profileImagePathKey: profileUrl,
            MyTwiLiteKeys.timelineImageNameKey: timelineImagePath
        ]
        fireStoreDatabase.collection(MyTwiLiteKeys.timelinesKey).addDocument(data: timelineInformation) { error in
            callBack(error)
        }
    }

    // MARK: - Post a timeline
    func postTimeline(timeline: AddTimeline, profileUrl: String, callBack: @escaping (Error?) -> Void) {
        // post timeline text
        if let timelineText = timeline.text, timeline.imageData == nil {
            self.addTimelineInformaion(timeline: timeline,
                                       text: timelineText,
                                       timelinePicturePath: "",
                                       timelineImagePath: "",
                                       profileUrl: profileUrl) {  timelineError in
                callBack(timelineError)
            }
            return
        }
        
        // post timeline picture
        if let imageData = timeline.imageData, timeline.text == nil {
            self.uploadProfilePicture(path: MyTwiLiteKeys.timelinePath,
                                      uid: timeline.uid,
                                      imageData: imageData,
                                      currentTimestemp: timeline.createdDate) { [weak self] imagePath, uploadProfilePictureError in
                if uploadProfilePictureError != nil {
                    callBack(uploadProfilePictureError)
                } else {
                    if let imagePath = imagePath {
                        self?.downloadImageUrl(imagePath: imagePath) { [weak self] result in
                            switch result {
                            case .success(let url):
                                self?.addTimelineInformaion(timeline: timeline, text: "",
                                                            timelinePicturePath: url.absoluteString,
                                                            timelineImagePath: imagePath,
                                                            profileUrl: profileUrl) { timelineError in
                                    callBack(timelineError)
                                }
                            case .failure(let downloadUrlPathError):
                                callBack(downloadUrlPathError)
                            }
                        }
                    }
                }
            }
            return
        }

        // post timeline text and picture
        if let timelineText = timeline.text, let imageData = timeline.imageData {
            self.uploadProfilePicture(path: MyTwiLiteKeys.timelinePath,
                                      uid: timeline.uid,
                                      imageData: imageData,
                                      currentTimestemp: timeline.createdDate) { [weak self] imagePath, uploadProfilePictureError in
                if uploadProfilePictureError != nil {
                    callBack(uploadProfilePictureError)
                } else {
                    if let imagePath = imagePath {
                        self?.downloadImageUrl(imagePath: imagePath) { [weak self] result in
                            switch result {
                            case .success(let url):
                                self?.addTimelineInformaion(
                                    timeline: timeline,
                                    text: timelineText,
                                    timelinePicturePath: url.absoluteString,
                                    timelineImagePath: imagePath,
                                    profileUrl: profileUrl) { timelineError in
                                    callBack(timelineError)
                                }
                            case .failure(let downloadUrlPathError):
                                callBack(downloadUrlPathError)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Fetch my timelines
    func fetchMyTimelines(callback: @escaping CollectionCallBackType) {
        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            let timelineCollection = Firestore.firestore().collection(MyTwiLiteKeys.timelinesKey).whereField(MyTwiLiteKeys.uidKey, isEqualTo: uid)
            timelineCollection.getDocuments { snapshot, error in
                callback(snapshot, error)
            }
        }
    }
    
    // MARK: - Fetch timelines
    func fetchTimelines(callback: @escaping CollectionCallBackType) {
        let timelineCollection = Firestore.firestore().collection(MyTwiLiteKeys.timelinesKey)
        timelineCollection.getDocuments { snapshot, error in
            callback(snapshot, error)
        }
    }
    
    // MARK: - Download image url
    func downloadImageUrl(imagePath: String, callBack: @escaping (Result<URL, Error>) -> Void) {
        Storage.storage().reference().child(imagePath).downloadURL { result in
             callBack(result)
        }
    }
    
    // MARK: - Delete timeline image
    func deleteTimelineImage(imageName: String, callBack: @escaping ((Error?) -> Void)) {
        Storage.storage().reference().child(imageName).delete(completion: callBack)
    }
    
    // MARK: - Delete timeline infomation
    func deleteTimelineInformation(documentId: String, callBack: @escaping ((Error?) -> Void)) {
        Firestore.firestore().collection(MyTwiLiteKeys.timelinesKey).document(documentId).delete(completion: callBack)
    }
    
    // MARK: - Delete timeline image
    func deleteTimeline(timeline: TimelineModel, isReachable: @escaping ((Bool) -> Void), callBack: @escaping ((Error?) -> Void)) {
        // delete timeline information
        if !FirebaseHelper.instance.connectedToNetwork() {
            isReachable(false)
            return
        }
        if let timelineText = timeline.text, !timelineText.isEmpty,
           let imageName = timeline.imageName, imageName.isEmpty {
            deleteTimelineInformation(documentId: timeline.documentId, callBack: callBack)
        }
        
        // delete timeline image and information
        if let imageName = timeline.imageName, !imageName.isEmpty {
            self.deleteTimelineInformation(documentId: timeline.documentId) { [weak self] error in
                if let error = error {
                    callBack(error)
                } else {
                    self?.deleteTimelineImage(imageName: imageName, callBack: callBack)
                }
            }
        }
    }
    
    // MARK: - Fetch user information
    func fetchUserInformation(callback: @escaping CollectionCallBackType) {
        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            let usersCollection = Firestore.firestore().collection(MyTwiLiteKeys.usersKey).whereField(MyTwiLiteKeys.uidKey, isEqualTo: uid)
            usersCollection.getDocuments { snapshot, error in
                callback(snapshot, error)
            }
        }
    }
    
    // MARK: - Check internet connectivity status
    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let networkReachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else { return false }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilitySetDispatchQueue(networkReachability, DispatchQueue.global(qos: .default))
        if SCNetworkReachabilityGetFlags(networkReachability, &flags) == false { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
}
