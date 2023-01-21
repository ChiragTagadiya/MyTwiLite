//
//  AddTimeLineViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

extension AddTimeLineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Image picker delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.imageViewTimeline.image = image
        dismiss(animated: true)
    }
}
