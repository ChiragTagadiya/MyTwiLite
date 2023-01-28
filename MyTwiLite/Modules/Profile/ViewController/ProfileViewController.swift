//
//  ProfileViewController.swift
//  MyTwiLite
//
//  Created by DC on 24/01/23.
//

import UIKit

class ProfileViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var textFieldFirstName: MyTwiLiteTextField!
    @IBOutlet weak var textFieldLastName: MyTwiLiteTextField!
    @IBOutlet weak var textFieldEmail: MyTwiLiteTextField!
    @IBOutlet weak var buttonLogOut: MyTwiLiteButton!
    
    var router = ProfileRouter()
    let viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        if let email = textFieldEmail.text, email.isEmpty {
            self.fetchUserInformation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.navigationTitle
        self.configureLayout()
        self.fetchUserInformation()
    }
    
    // MARK: - Configure initial layout
    private func configureLayout() {
        self.imageViewProfile.setCornerRadius()
        self.buttonLogOut.setFilledLayout()
    }
    
    // MARK: - Fetch user information
    private func fetchUserInformation() {
        if !self.viewModel.connectedToNetwork() {
            self.showAlert(message: self.viewModel.noInternetTitle)
            return
        }
        self.showLoader()
        self.viewModel.fetchUserInformation {[weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            default:
                break
            }
        
            self?.textFieldFirstName.text = self?.viewModel.userProfile?.firstName
            self?.textFieldLastName.text = self?.viewModel.userProfile?.lastName
            self?.textFieldEmail.text = self?.viewModel.userProfile?.email
            let profilePlaceholderImage = UIImage(named: MyTwiLiteKeys.profilePlaceholder)
            self?.imageViewProfile.kf.setImage(with: self?.viewModel.userProfile?.profilePath,
                                              placeholder: profilePlaceholderImage)
            self?.hideLoader()
        }
    }

    // MARK: - Logout action
    @IBAction func onLogOutPressed(_ sender: UIButton) {
        self.showLoader()
        self.viewModel.logOut { [weak self] _ in
            self?.hideLoader()
            self?.showAlert(message: self?.viewModel.noInternetTitle ?? "")
        } callback: { [weak self] result in
            self?.hideLoader()
            switch result {
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            default:
                self?.router.route(to: .logIn, from: self ?? ProfileViewController().self, parameters: nil)
            }
        }
    }
}
