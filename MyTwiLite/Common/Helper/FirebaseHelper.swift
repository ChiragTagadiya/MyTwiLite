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

class FirebaseHelper {
    static let instance = FirebaseHelper()
    
    // MARK: - Fetch current user
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - SignUp user
    func createUser(user: UserDetail, callBack: @escaping FirebaseCallBackType) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if let uid = result?.user.uid {
                self.uploadProfilePicture(path: MyTwiLiteKeys.profilePath, uid: uid,
                                          imageData: user.profileImageData, currentTimestemp: nil) { imagePath, uploadProfilePictureError in
                    if uploadProfilePictureError != nil {
                        callBack(nil, uploadProfilePictureError)
                    } else {
                        if let imagePath = imagePath {
                            self.addUserInformaion(uid: uid, profilePicturePath: imagePath, user: user) { userInformationError in
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
    
    // MARK: - LogIn user
    func logInUser(email: String, password: String, callBack: @escaping FirebaseCallBackType) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            callBack(result, error)
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
                               text: String, timelinePicturePath: String,
                               profileUrl: String,
                               callBack: @escaping (Error?) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        let timelineInformation = [
            MyTwiLiteKeys.uidKey: timeline.uid,
            MyTwiLiteKeys.timelineTextKey: text,
            MyTwiLiteKeys.timelineImagePathKey: timelinePicturePath,
            MyTwiLiteKeys.createdDateKey: timeline.createdDate,
            MyTwiLiteKeys.profileImagePathKey: profileUrl
        ]
        fireStoreDatabase.collection(MyTwiLiteKeys.timelinesKey).addDocument(data: timelineInformation) { error in
            callBack(error)
        }
    }

    // MARK: - Post a timeline
    func postTimeline(timeline: AddTimeline, profileUrl: String, callBack: @escaping (Error?) -> Void) {
        // post timeline text
        if let timelineText = timeline.text, timeline.imageData == nil {
            self.addTimelineInformaion(timeline: timeline, text: timelineText, timelinePicturePath: "", profileUrl: profileUrl) {  timelineError in
                callBack(timelineError)
            }
            return
        }
        
        // post timeline picture
        if let imageData = timeline.imageData, timeline.text == nil {
            self.uploadProfilePicture(path: MyTwiLiteKeys.timelinePath, uid: timeline.uid,
                                      imageData: imageData, currentTimestemp: timeline.createdDate) { imagePath, uploadProfilePictureError in
                if uploadProfilePictureError != nil {
                    callBack(uploadProfilePictureError)
                } else {
                    if let imagePath = imagePath {
                        self.downloadImageUrl(imagePath: imagePath) { result in
                            switch result {
                            case .success(let url):
                                self.addTimelineInformaion(timeline: timeline, text: "",
                                                           timelinePicturePath: url.absoluteString, profileUrl: profileUrl) { timelineError in
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
            self.uploadProfilePicture(path: MyTwiLiteKeys.timelinePath, uid: timeline.uid,
                                      imageData: imageData, currentTimestemp: timeline.createdDate) { imagePath, uploadProfilePictureError in
                if uploadProfilePictureError != nil {
                    callBack(uploadProfilePictureError)
                } else {
                    if let imagePath = imagePath {
                        self.downloadImageUrl(imagePath: imagePath) { result in
                            switch result {
                            case .success(let url):
                                self.addTimelineInformaion(
                                    timeline: timeline,
                                    text: timelineText, timelinePicturePath: url.absoluteString,
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
}
