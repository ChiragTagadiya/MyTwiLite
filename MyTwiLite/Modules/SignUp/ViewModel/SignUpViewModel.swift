//
//  SignUpViewModel.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation

class SignUpViewModel {
    // MARK: - Variables
    let navigationTitle = MyTwiLiteStrings.signUp
    let validFirstNameTitle = MyTwiLiteStrings.validFirstName
    let validLastNameTitle = MyTwiLiteStrings.validLastName
    let validEmailTitle = MyTwiLiteStrings.validEmail
    let validPasswordTitle = MyTwiLiteStrings.validPassword
    let validConfirmPasswordTitle = MyTwiLiteStrings.validConfirmPassword
    let editIconTitle = MyTwiLiteKeys.editIconKey
    var isValid = true

    // MARK: - Validate user detail with a type
    public func isUserDetailValid(text: String?, validationType: Validation) -> Bool {
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
    public func createUser(_ userDetail: UserDetail, callBack: @escaping FirebaseCallBackType) {
        FirebaseHelper.instance.createUser(user: userDetail) { (result, error) in
            callBack(result, error)
        }
    }
}
