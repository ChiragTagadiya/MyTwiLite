//
//  SignUpViewController.swift
//  MyTwiLite
//
//  Created by DC on 19/01/23.
//

import Foundation
import UIKit

class SignUpViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var labelSignUp: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var buttonAddPicture: UIButton!
    @IBOutlet weak var buttonSignUp: MyTwiLiteButton!
    @IBOutlet weak var textFieldFirstName: MyTwiLiteTextField!
    @IBOutlet weak var textFieldLastName: MyTwiLiteTextField!
    @IBOutlet weak var textFieldEmail: MyTwiLiteTextField!
    @IBOutlet weak var textFieldPassword: MyTwiLiteTextField!
    @IBOutlet weak var textFieldConfirmPassword: MyTwiLiteTextField!

    var router = SignUpRouter()
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }

    // MARK: - Configure initial view layout
    private func configureLayout() {
        self.shouldHideBackButton = true
        self.labelSignUp.textColor = Colors.green
        self.imageViewProfile.setCornerRadius()
        self.buttonAddPicture.setImage(UIImage(named: viewModel.plusIconTitle), for: .normal)
        self.buttonAddPicture.setCornerRadius()
        self.buttonSignUp.setFilledLayout()
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
        if !viewModel.isUserDetailValid(text: textFieldFirstName.text, validationType: .normalText) {
            self.viewModel.isValid = false
            self.textFieldFirstName.errorMessage = viewModel.validFirstNameTitle
        }
        if !viewModel.isUserDetailValid(text: textFieldLastName.text, validationType: .normalText) {
            self.viewModel.isValid = false
            self.textFieldLastName.errorMessage = viewModel.validLastNameTitle
        }
        if !viewModel.isUserDetailValid(text: textFieldEmail.text, validationType: .email) {
            self.viewModel.isValid = false
            self.textFieldEmail.errorMessage = viewModel.validEmailTitle
        }
        if !viewModel.isUserDetailValid(text: textFieldPassword.text, validationType: .password) {
            self.viewModel.isValid = false
            self.textFieldPassword.errorMessage = viewModel.validPasswordTitle
        }
        if let password = textFieldConfirmPassword.text, password.isEmpty ||
            textFieldConfirmPassword.text != textFieldPassword.text {
            self.viewModel.isValid = false
            self.textFieldConfirmPassword.errorMessage = viewModel.validConfirmPasswordTitle
        }
    
        if !self.viewModel.isValid {
            return
        }
        
        if let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text,
           let email = textFieldEmail.text, let password = textFieldPassword.text,
           let profileImageData = imageViewProfile.image?.jpegData(compressionQuality: 0.6) {
            let user = UserDetail(firstName: firstName, lastName: lastName,
                                  email: email, password: password, profileImageData: profileImageData)

            self.showLoader()
            self.viewModel.createUser(user) { [weak self] _, error in
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
        self.buttonAddPicture.setImage(UIImage(named: viewModel.editIconTitle), for: .normal)
        self.imageViewProfile.image = image
        dismiss(animated: true)
    }
}
