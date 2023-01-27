//
//  ProfileViewModel.swift
//  MyTwiLite
//
//  Created by DC on 25/01/23.
//

import Foundation
import Firebase

class ProfileViewModel {
    // MARK: - Variables
    let navigationTitle = MyTwiLiteStrings.profile
    let noInternetTitle = MyTwiLiteStrings.noInternet
    var userProfile: UserProfileModel?
    
    // MARK: - Prepare user data
    private func prepareUserData(snapshot: QuerySnapshot?,
                                 profilePath: URL,
                                 callBack: @escaping (Result<Int, Error>) -> Void) {
        if let snapshot = snapshot, let document = snapshot.documents.first {
            let userProfileData = document.data()
            var userProfile = UserProfileModel(documentId: document.documentID, profilePath: profilePath)
            userProfile.firstName = userProfileData[MyTwiLiteKeys.firstNameKey] as? String
            userProfile.lastName = userProfileData[MyTwiLiteKeys.lastNameKey] as? String
            userProfile.email = FirebaseHelper.instance.currentUser()?.email
            self.userProfile = userProfile
        }
        callBack(.success(0))
    }
    
    // MARK: - Fetch user information
    func fetchUserInformation(callBack: @escaping (Result<Int, Error>) -> Void) {
        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            let profileImagePath = "\(MyTwiLiteKeys.profilePath)\(uid).\(MyTwiLiteKeys.jpgExtension)"
            FirebaseHelper.instance.downloadImageUrl(imagePath: profileImagePath) { result in
                switch result {
                case .success(let profileUrl):
                    FirebaseHelper.instance.fetchUserInformation { [weak self] snapshot, error in
                        if let error = error {
                            callBack(.failure(error))
                        } else {
                            self?.prepareUserData(snapshot: snapshot, profilePath: profileUrl, callBack: callBack)
                        }
                    }
                case .failure(let profileUrlError):
                    debugPrint(profileUrlError.localizedDescription)
                    callBack(.failure(profileUrlError))
                }
            }
        }
    }
    
    // MARK: - Log out user
    func logOut(isReachable: @escaping ((Bool) -> Void), callback: @escaping (Result<Int, Error>) -> Void) {
        FirebaseHelper.instance.logOut(isReachable: isReachable, callback: callback)
    }
    
    // MARK: - Cheeck network status
    func connectedToNetwork() -> Bool {
        return FirebaseHelper.instance.connectedToNetwork()
    }
}
