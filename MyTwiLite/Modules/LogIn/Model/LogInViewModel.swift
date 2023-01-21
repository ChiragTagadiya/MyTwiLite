//
//  LogInViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

class LogInViewModel {
    func signinUser(email: String, password: String, callBack: @escaping FirebaseCallBackType) {
        // TODO: Validate userEmail, password etc..
        // if error, create custom error, then callback(nil, error)
        FirebaseHelper.instance.logInUser(email: email, password: password){ (result, error) in
            callBack(result, error)
        }
    }
}
