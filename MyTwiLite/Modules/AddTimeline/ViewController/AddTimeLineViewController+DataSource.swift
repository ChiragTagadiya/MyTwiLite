//
//  AddTimelineViewController+DataSource.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

extension AddTimelineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Image picker delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.imageViewTimeline.image = image
        self.vewImageTimeline.isHidden = false
        dismiss(animated: true)
    }
}

extension AddTimelineViewController: UITextViewDelegate {
    // MARK: - Text view delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            isTextPlaceholder = false
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            isTextPlaceholder = true
            textView.text = MyTwiLiteStrings.timelineTextPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
