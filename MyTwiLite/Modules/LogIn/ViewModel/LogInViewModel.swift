//
//  LogInViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

class LogInViewModel {
    
    // MARK: - Validate user detail with a type
    func isUserDetailValid(text: String?, validationType: Validation) -> Bool {
        let utils = Utils()
        switch validationType {
        case .normalText:
            return  utils.isValidText(text)

        case .email:
            return utils.isValidEmail(text)

        case .password:
            return utils.isValidLogInPassword(text)
        }
    }
    
    // MARK: - Sign in with user email and password
    func signinUser(email: String, password: String, callBack: @escaping FirebaseCallBackType) {
        FirebaseHelper.instance.logInUser(email: email, password: password) { (result, error) in
            callBack(result, error)
        }
    }
}
