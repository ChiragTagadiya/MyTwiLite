//
//  LogInViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit
import Firebase

class LoginViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var router = LogInRouter()
    var viewModel = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.navigationTitle
        self.shouldHideBackButton = true
    }
    
    // MARK: - Navigate to home action
    private func navigateToHome() {
        self.router.route(to: .dashboard, from: self, parameters: nil)
    }
    
    // MARK: - Navigate to sign-up  action
    private func navigateToSignUp() {
        self.router.route(to: .signUp, from: self, parameters: nil)
    }
    
    // MARK: - On log-in button action
    @IBAction func logInPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        if !viewModel.isUserDetailValid(text: textFieldEmail.text, validationType: .email) {
            showAlert(message: viewModel.validEmailTitle)
            return
        } else if !viewModel.isUserDetailValid(text: textFieldPassword.text, validationType: .password) {
            showAlert(message: viewModel.validPasswordTitle)
            return
        }
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            self.showLoader()
            viewModel.signinUser(email: email, password: password) { [weak self] (_, error) in
                self?.hideLoader()
                if let error = error {
                    self?.showAlert(message: error.localizedDescription)
                } else {
                    self?.navigateToHome()
                }
            }
        }
    }

    // MARK: - On sign-up button action
    @IBAction func onSignUpButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigateToSignUp()
    }
}
