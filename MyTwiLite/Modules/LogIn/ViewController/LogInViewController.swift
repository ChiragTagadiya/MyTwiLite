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
        self.title = "Login"
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
        if !viewModel.isUserDetailValid(text: textFieldEmail.text, validationType: .email) {
            showAlert(message: "Please enter valid email")
            return
        } else if !viewModel.isUserDetailValid(text: textFieldPassword.text, validationType: .password) {
            showAlert(message: "Please enter valid password")
            return
        }
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            viewModel.signinUser(email: email, password: password) { [weak self] (_, error) in
                if let error = error {
                    self?.showAlert(message: error.localizedDescription)
                } else {
                    self?.navigateToHome()
                }
            }
        } else {
            print("Please enter email or password")
        }
    }

    // MARK: - On sign-up button action
    @IBAction func onSignUpButtonPressed(_ sender: UIButton) {
        self.navigateToSignUp()
    }
}
