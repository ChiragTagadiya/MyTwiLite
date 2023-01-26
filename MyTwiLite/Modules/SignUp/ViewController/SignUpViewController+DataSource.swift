//
//  SignUpViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 26/01/23.
//

import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.isValid = true
        (textField as? MyTwiLiteTextField)?.errorMessage = ""
    }
}
