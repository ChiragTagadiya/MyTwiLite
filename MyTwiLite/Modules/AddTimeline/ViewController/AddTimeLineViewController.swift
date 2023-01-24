//
//  AddTimelineViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class AddTimelineViewController: MyTwiLiteViewController {
    // MARK: - Outlets & Variables
    @IBOutlet weak var textFieldTimeline: UITextView!
    @IBOutlet weak var buttonAddPicture: UIButton!
    @IBOutlet weak var vewImageTimeline: UIView!
    @IBOutlet weak var imageViewTimeline: UIImageView!
    
    let viewModel = AddTimelineViewModel()
    var isTextPlaceholder = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK: - Configure initial layout
    private func configureLayout() {
        textFieldTimeline.text = MyTwiLiteStrings.timelineTextPlaceholder
        buttonAddPicture.setTitle(MyTwiLiteStrings.addPicture, for: .normal)
        textFieldTimeline.textColor = UIColor.lightGray
    }
    
    // MARK: - Add timeline picture action
    @IBAction func onAddPictureAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    // MARK: - Post timeline action
    @IBAction func onPostAction(_ sender: UIButton) {
        self.view.endEditing(true)
        var timelineImageData: Data?
        if let imageData = imageViewTimeline.image?.jpegData(compressionQuality: 0.6) {
            timelineImageData = imageData
        }
        if !viewModel.isTimelineValid(text: textFieldTimeline.text, imageData: timelineImageData) {
            showAlert(message: MyTwiLiteStrings.validTimeline)
            return
        }
        
        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            self.showLoader()
            viewModel.postTimeline(uid, timelineText: textFieldTimeline.text,
                                   timlineImageData: timelineImageData) { [weak self] result in
                self?.hideLoader()
                switch result {
                case .success:
                    self?.dismiss(animated: true)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    @IBAction func onRemovePictureAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.showCustomAlert(message: MyTwiLiteStrings.removeTimelineImageMessage) { _ in
            self.imageViewTimeline.image = nil
            self.vewImageTimeline.isHidden = true
        }
    }
}
