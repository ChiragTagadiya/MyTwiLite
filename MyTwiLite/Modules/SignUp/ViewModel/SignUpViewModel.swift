//
//  SignUpViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

protocol SignUpUser {
    func createUser(_ userDetail: UserDetail, isReachable: ((Bool) -> Void)?, callBack: @escaping FirebaseCallBackType)
}

class SignUpViewModel: SignUpUser {
    // MARK: - Variables
    let navigationTitle = MyTwiLiteStrings.signUp
    let validFirstNameTitle = MyTwiLiteStrings.validFirstName
    let validLastNameTitle = MyTwiLiteStrings.validLastName
    let validEmailTitle = MyTwiLiteStrings.validEmail
    let validPasswordTitle = MyTwiLiteStrings.validPassword
    let validConfirmPasswordTitle = MyTwiLiteStrings.validConfirmPassword
    let editIconTitle = MyTwiLiteKeys.editIconKey
    let noInternetTitle = MyTwiLiteStrings.noInternet
    var isValid = true

    // MARK: - Validate user detail with a type
    func isUserDetailValid(text: String?, validationType: Validation) -> Bool {
        let utils = Utils()
        switch validationType {
        case .normalText:
            return  utils.isValidText(text)

        case .email:
            return utils.isValidEmail(text)

        case .password:
            return utils.isValidPassword(text)
        }
    }
    
    // MARK: - Create a new user
    func createUser(_ userDetail: UserDetail, isReachable: ((Bool) -> Void)?, callBack: @escaping FirebaseCallBackType) {
        FirebaseHelper.instance.createUser(user: userDetail, isReachable: isReachable, callBack: callBack)
    }
}
