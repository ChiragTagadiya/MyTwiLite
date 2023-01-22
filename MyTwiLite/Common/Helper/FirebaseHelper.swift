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
    
    // MARK: - fetch current user
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - SignUp user
    func createUser(user: UserDetail, callBack: @escaping FirebaseCallBackType) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if let uid = result?.user.uid {
                self.uploadProfilePicture(uid: uid, imageData: user.profileImageData) { imagePath, uploadProfilePictureError in
                    if error != nil {
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
            MyTwiLiteStrings.uidKey: uid,
            MyTwiLiteStrings.firstNameKey: user.firstName,
            MyTwiLiteStrings.lastNameKey: user.lastName,
            MyTwiLiteStrings.profileImagePathKey: profilePicturePath
        ]
        fireStoreDatabase.collection(MyTwiLiteStrings.usersKey).addDocument(data: userInformation) { error in
            if error != nil {
                callBack(error)
            } else {
                callBack(nil)
            }
        }
    }
    
    // MARK: - Upload a user profile picture
    func uploadProfilePicture(uid: String, imageData: Data, callBack: @escaping (String?, Error?) -> Void) {
        let storageReference = Storage.storage().reference()
        let filePath = "\(MyTwiLiteStrings.profilePath)\(uid).\(MyTwiLiteStrings.jpgExtension)"
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
}
