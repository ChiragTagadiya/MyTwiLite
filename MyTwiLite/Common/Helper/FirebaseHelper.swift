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
                                          imageData: user.profileImageData) { imagePath, uploadProfilePictureError in
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
                              currentTimestemp: String = "", callBack: @escaping (String?, Error?) -> Void) {
        let storageReference = Storage.storage().reference()
        let filePath = "\(path)\(uid)_\(currentTimestemp).\(MyTwiLiteKeys.jpgExtension)"
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
                               callBack: @escaping (Error?) -> Void) {
        let fireStoreDatabase = Firestore.firestore()
        let timelineInformation = [
            MyTwiLiteKeys.uidKey: timeline.uid,
            MyTwiLiteKeys.timelineTextKey: text,
            MyTwiLiteKeys.timelineImagePathKey: timelinePicturePath,
            MyTwiLiteKeys.createdDateKey: timeline.createdDate
        ]
        fireStoreDatabase.collection(MyTwiLiteKeys.timelinesKey).addDocument(data: timelineInformation) { error in
            callBack(error)
        }
    }

    // MARK: - Post a timeline
    func postTimeline(timeline: AddTimeline, callBack: @escaping (Error?) -> Void) {
        // post timeline text
        if let timelineText = timeline.text, timeline.imageData == nil {
            self.addTimelineInformaion(timeline: timeline, text: timelineText, timelinePicturePath: "") {  timelineError in
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
                        self.addTimelineInformaion(timeline: timeline, text: "", timelinePicturePath: imagePath) {  timelineError in
                            callBack(timelineError)
                        }
                    } else {
                        callBack(uploadProfilePictureError)
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
                        self.addTimelineInformaion(timeline: timeline, text: timelineText, timelinePicturePath: imagePath) {  timelineError in
                            callBack(timelineError)
                        }
                    } else {
                        callBack(uploadProfilePictureError)
                    }
                }
            }
        }
    }
    
    // MARK: - Fetch timelines
    func fetchTimelines(callback: @escaping CollectionCallBackType) {
        let timelineCollection = Firestore.firestore().collection(MyTwiLiteKeys.timelineCollection)
        timelineCollection.getDocuments { snapshot, error in
            callback(snapshot, error)
        }
    }
}
