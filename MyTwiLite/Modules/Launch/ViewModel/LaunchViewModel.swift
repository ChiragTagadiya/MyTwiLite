//
//  LaunchViewModel.swift
//  MyTwiLite
//
//  Created by DC on 25/01/23.
//

import Foundation

class LaunchViewModel {
    // MARK: - Check user login status
    func isUserLogin() -> Bool {
        return Utils().getLoginStatus() && FirebaseHelper.instance.currentUser() != nil
    }
}
