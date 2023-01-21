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

    private func configureLayout() {
        self.imageViewProfile.setCornerRadius()
    }
    
    //MARK: - Navigate to login action
    private func navigateToLogin() {
        self.router.route(to: .logIn, from: self, parameters: nil)
    }
    
    private func navigateToHome() {
        self.router.route(to: .dashboard, from: self, parameters: nil)
    }

    //MARK: - Profile picture picker action
    @IBAction func selectProfilePressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }

    //MARK: - Sign up action
    @IBAction func signeUpPressed(_ sender: UIButton) {
        // validate all the fields
        if let firstName = textFieldFirstName.text, let lastName = textFieldLastName.text, let email = textFieldEmail.text, let password = textFieldPassword.text, let profileImageData = imageViewProfile.image?.jpegData(compressionQuality: 0.6) {
            if textFieldPassword.text != textFieldConfirmPassword.text {
                self.showAlert(message: "Password and confirm passwod are different.")
                return
            }
            
            let user = UserDetail(firstName: firstName, lastName: lastName, email: email, password: password, profileImageData: profileImageData)

            viewModel.createUser(user) { [weak self] result, error in
                if let error = error {
                    let errorMessage = error.localizedDescription
                    self?.showAlert(message: errorMessage)
                } else {
                    self?.navigateToHome()
                }
            }
        } else {
            print("Please enter valid and required details")
        }
    }
    
    //MARK: - Login action
    @IBAction func logInPressed(_ sender: UIButton) {
        navigateToLogin()
    }    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Image picker delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.imageViewProfile.image = image
        dismiss(animated: true)
    }
}
