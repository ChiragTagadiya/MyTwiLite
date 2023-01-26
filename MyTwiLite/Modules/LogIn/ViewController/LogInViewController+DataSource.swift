//
//  LogInViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 27/01/23.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.isValid = true
        (textField as? MyTwiLiteTextField)?.errorMessage = ""
    }
}
