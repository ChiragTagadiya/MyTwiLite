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

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Image picker delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.buttonAddPicture.setImage(UIImage(systemName: viewModel.editIconTitle,
                                               withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
        self.imageViewProfile.image = image
        dismiss(animated: true)
    }
}
