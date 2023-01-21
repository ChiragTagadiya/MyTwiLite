//
//  LogInViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit
import Firebase

class LoginViewController: MyTwiLiteViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var router = LogInRouter()
    var viewModel = LogInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.shouldHideBackButton = true
    }
    
    //MARK: - Navigate to home action
    private func navigateToHome() {
        self.router.route(to: .dashboard, from: self, parameters: nil)
    }
    
    private func navigateToSignUp() {
        self.router.route(to: .signUp, from: self, parameters: nil)
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            viewModel.signinUser(email: email, password: password) { [weak self] (result, error) in
                if let error = error {
                    let errorMessage = error.localizedDescription
                    self?.showAlert(message: errorMessage)
                } else {
                    self?.navigateToHome()
                }
            }
        } else {
            print("Please enter email or password")
        }
    }
    
    @IBAction func onSignUpButtonPressed(_ sender: UIButton) {
        self.navigateToSignUp()
    }
}
