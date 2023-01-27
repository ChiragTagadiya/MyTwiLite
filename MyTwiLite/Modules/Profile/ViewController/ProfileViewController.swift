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
    @IBOutlet weak var buttonDelete: MyTwiLiteButton!
    
    let viewModel = ProfileViewModel()

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
        self.buttonDelete.setFilledLayout(Colors.red)
    }
    
    // MARK: - Fetch user information
    private func fetchUserInformation() {
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
    }
    
    // MARK: - Delete account action
    @IBAction func onDeletePressed(_ sender: UIButton) {
    }
}
