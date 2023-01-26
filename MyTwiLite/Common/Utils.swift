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
        // check for password and whitespaces
        if let password = password, password.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        let emailRegularExpression = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
        return emailPredicate.evaluate(with: password)
    }
    
    // MARK: - Validate a login password
    func isValidLogInPassword(_ password: String?) -> Bool {
        // check for password and whitespaces
        if let password = password, password.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - Validate image
    func isValidImage(_ imageData: Data?) -> Bool {
        // check for valid image data
        if imageData == nil {
            return false
        }
        return true
    }

    // MARK: - Current date timestamp
    func currentTimestamp() -> String {
        let date = Date().timeIntervalSince1970
        return "\(date)"
    }
    
    // MARK: - Convert timestamp string to date
    func convertTimespampToDate(timestamp: String?) -> Date {
        if let timestamp = timestamp, let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = MyTwiLiteKeys.normalDateFormat
            let stringDate = dateFormatter.string(from: date)
            if let formattedDate = dateFormatter.date(from: stringDate) {
                return formattedDate
            }
        }
        return Date()
    }
    
    // MARK: - Convert timestamp string to date string
    func convertTimespampToDateString(timestamp: String?) -> String {
        if let timestamp = timestamp, let unixTime = Double(timestamp) {
            let createdDate = Date(timeIntervalSince1970: unixTime)
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            let relativeDate = formatter.localizedString(for: createdDate, relativeTo: Date.now)
            return relativeDate
        }
        return ""
    }
    
    // MARK: - set value to userdefault
    func setLoginStatus(isLogin: Bool) {
        UserDefaults.standard.setValue(isLogin, forKey: MyTwiLiteKeys.isLoginKey)
    }
    
    // MARK: - get value to userdefault
    func getLoginStatus() -> Bool {
        if let value =  UserDefaults.standard.value(forKey: MyTwiLiteKeys.isLoginKey) as? Bool {
            return value
        }
        return false
    }
}
