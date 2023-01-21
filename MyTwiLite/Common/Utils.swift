//
//  Utils.swift
//  MyTwiLite
//
//  Created by DC on 22/01/23.
//

import Foundation

struct Utils {
    // MARK: - Validate a normal string
    func isValidText(_ text: String?) -> Bool {
        if let text = text { // check for empty text
            // check for whitespaces
            if text.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
            return true
        }
        return false
    }
    
    // MARK: - Validate an email
    func isValidEmail(_ email: String?) -> Bool {
        // check for empty email and whitespaces
        if let email = email, email.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: - Validate a password
    func isValidPassword(_ password: String?) -> Bool {
        // check for empty email and whitespaces
        if let password = password, password.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        let emailRegularExpression = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
        return emailPredicate.evaluate(with: password)
    }
    
    // MARK: - Validate a login password
    func isValidLogInPassword(_ password: String?) -> Bool {
        // check for empty email and whitespaces
        if let password = password, password.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
}
