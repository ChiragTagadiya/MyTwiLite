//
//  LogInViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

class LogInViewModel {
    // MARK: - Variables
    let navigationTitle = MyTwiLiteStrings.logIn
    let validEmailTitle = MyTwiLiteStrings.validEmail
    let validPasswordTitle = MyTwiLiteStrings.validPassword

    // MARK: - Validate user detail with a type
    func isUserDetailValid(text: String?, validationType: Validation) -> Bool {
        let utils = Utils()
        switch validationType {
        case .email:
            return utils.isValidEmail(text)

        case .password:
            return utils.isValidLogInPassword(text)

        default:
            return false
        }
    }
    
    // MARK: - Sign in with user email and password
    func signinUser(email: String, password: String, callBack: @escaping FirebaseCallBackType) {
        FirebaseHelper.instance.logInUser(email: email, password: password) { (result, error) in
            callBack(result, error)
        }
    }
}
