//
//  SignUpViewController.swift
//  MyTwiLite
//
//  Created by DC on 19/01/23.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!

    var router = SignUpRouter()
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = MyTwiLiteStrings.signUp
        self.shouldHideBackButton = true
        self.configureLayout()
    }

    // MARK: - Configure initial view layout
    private func configureLayout() {
        self.imageViewProfile.setCornerRadius()
    }
    
    // MARK: - Navigate to login action
    private func navigateToLogin() {
        self.view.endEditing(true)
        self.router.route(to: .logIn, from: self, parameters: nil)
    }
    
    // MARK: - Navigate to home action
    private func navigateToHome() {
        self.router.route(to: .dashboard, from: self, parameters: nil)
    }

    // MARK: - Profile picture picker action
    @IBAction func selectProfilePressed(_ sender: UIButton) {
        self.view.endEditing(true)
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }

    // MARK: - On sign-up button action
    @IBAction func signeUpPressed(_ sender: UIButton) {
        // validate all the fields
        self.view.endEditing(true)
        if imageViewProfile.image == nil {
            showAlert(message: MyTwiLiteStrings.selectProfilePic)
            return
        } else if !viewModel.isUserDetailValid(text: textFieldFirstName.text, validationType: .normalText) {
            showAlert(message: MyTwiLiteStrings.validFirstName)
            return
        } else if !viewModel.isUserDetailValid(text: textFieldLastName.text, validationType: .normalText) {
            showAlert(message: MyTwiLiteStrings.validLastName)
            return
        } else if !viewModel.isUserDetailValid(text: textFieldEmail.text, validationType: .email) {
            showAlert(message: MyTwiLiteStrings.validEmail)
            return
        } else if !viewModel.isUserDetailValid(text: textFieldPassword.text, validationType: .password) {
            showAlert(message: MyTwiLiteStrings.validPassword)
            return
        } else if textFieldConfirmPassword.text != textFieldPassword.text {
            showAlert(message: MyTwiLiteStrings.validConfirmPassword)
            return
        }
    
        if let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text,
           let email = textFieldEmail.text, let password = textFieldPassword.text,
           let profileImageData = imageViewProfile.image?.jpegData(compressionQuality: 0.6) {
            let user = UserDetail(firstName: firstName, lastName: lastName,
                                  email: email, password: password, profileImageData: profileImageData)

            self.showLoader()
            viewModel.createUser(user) { [weak self] _, error in
                self?.hideLoader()
                if let error = error {
                    self?.showAlert(message: error.localizedDescription)
                } else {
                    self?.navigateToHome()
                }
            }
        }
    }
    
    // MARK: - On log-in button action
    @IBAction func logInPressed(_ sender: UIButton) {
        navigateToLogin()
    }    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Image picker delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.imageViewProfile.image = image
        dismiss(animated: true)
    }
}
