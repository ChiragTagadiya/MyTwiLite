//
//  SignUpViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

class SignUpViewModel {
    func createUser(_ user: UserDetail, callBack: @escaping FirebaseCallBackType) {
        // TODO: Validate userEmail, password etc..
        // if error, create custom error, then callback(nil, error)
        FirebaseHelper.instance.createUser(user: user) { (result, error) in
            callBack(result, error)
        }
    }
}
