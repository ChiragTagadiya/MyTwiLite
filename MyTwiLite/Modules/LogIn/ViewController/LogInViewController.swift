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
    
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var textFieldEmail: MyTwiLiteTextField!
    @IBOutlet weak var textFieldPassword: MyTwiLiteTextField!
    @IBOutlet weak var buttonLogin: MyTwiLiteButton!

    var router = LogInRouter()
    var viewModel = LogInViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initializeData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }
    
    // MARK: - Configure initial view layout
    private func configureLayout() {
        self.shouldHideBackButton = true
        self.labelLogin.text = self.viewModel.navigationTitle
        self.labelLogin.textColor = Colors.green
        self.buttonLogin.setFilledLayout()
    }
    
    // MARK: - Initialize data
    private func initializeData() {
        self.textFieldEmail.text = ""
        self.textFieldEmail.errorMessage = ""
        self.textFieldPassword.text = ""
        self.textFieldPassword.errorMessage = ""
        self.textFieldPassword.isSecureTextEntry = true
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
        if !self.viewModel.isUserDetailValid(text: textFieldEmail.text, validationType: .email) {
            self.viewModel.isValid = false
            self.textFieldEmail.errorMessage = self.viewModel.validEmailTitle
        }
        if !self.viewModel.isUserDetailValid(text: textFieldPassword.text, validationType: .password) {
            self.viewModel.isValid = false
            self.textFieldPassword.errorMessage = self.viewModel.validPasswordTitle
        }
        
        if !self.viewModel.isValid {
            return
        }
        
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            self.showLoader()
            self.viewModel.signinUser(email: email, password: password) { [weak self] _ in
                self?.hideLoader()
                self?.showAlert(message: self?.viewModel.noInternetTitle ?? "")
            } callBack: { [weak self] (_, error) in
                self?.hideLoader()
                if let error = error {
                    self?.showAlert(message: error.localizedDescription)
                } else {
                    self?.navigateToHome()
                }
            }
        }
    }
    
    // MARK: - On password hide/ show action
    @IBAction func onVisiblePasswordPressed(_ sender: UIButton) {
        self.textFieldPassword.isSecureTextEntry = !self.textFieldPassword.isSecureTextEntry
    }
    
    // MARK: - On sign-up button action
    @IBAction func onSignUpButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigateToSignUp()
    }
}
