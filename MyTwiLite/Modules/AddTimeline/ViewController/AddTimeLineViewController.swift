//
//  AddTimelineViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class AddTimelineViewController: MyTwiLiteViewController {
    // MARK: - Variables & Outlets
    @IBOutlet weak var textFieldTimeline: UITextView!
    @IBOutlet weak var buttonAddPicture: UIButton!
    @IBOutlet weak var buttonPost: MyTwiLiteButton!
    @IBOutlet weak var vewImageTimeline: UIView!
    @IBOutlet weak var imageViewTimeline: UIImageView!
    
    @IBOutlet weak var constraintAddPictureHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintImageViewHeight: NSLayoutConstraint!

    let viewModel = AddTimelineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK: - Configure initial layout
    private func configureLayout() {
        textFieldTimeline.text = viewModel.timelinePlaceholderTitle
        buttonAddPicture.setTitle(viewModel.addPictureTitle, for: .normal)
        textFieldTimeline.textColor = UIColor.lightGray
        self.textFieldTimeline.setCornerRadius()
        self.buttonPost.setFilledLayout()
        self.constraintImageViewHeight.constant = 0
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
            showAlert(message: viewModel.validTimelineTitle)
            return
        }
        
        if let uid = FirebaseHelper.instance.currentUser()?.uid {
            self.showLoader()
            let timelineText = !(viewModel.isTextPlaceholder) ? textFieldTimeline.text : nil
            viewModel.postTimeline(uid, timelineText: timelineText,
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

    // MARK: - Remove picture action
    @IBAction func onRemovePictureAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.showCustomAlert(message: viewModel.removeTimelineImageTitle) { [weak self] _ in
            self?.imageViewTimeline.image = nil
            self?.buttonAddPicture.isHidden = false
            self?.vewImageTimeline.isHidden = true
            self?.constraintAddPictureHeight.constant = 24
            self?.constraintImageViewHeight.constant = 0
        }
    }
    
    // MARK: - On back action
    @IBAction func onBackAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
