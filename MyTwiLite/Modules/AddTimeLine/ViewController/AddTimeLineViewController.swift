//
//  AddTimeLineViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit

class AddTimeLineViewController: MyTwiLiteViewController {

    //MARK: - Outlets & Variables
    @IBOutlet weak var textFieldTimeline: UITextField!
    @IBOutlet weak var imageViewTimeline: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    //MARK: - Add timeline picture action
    @IBAction func onAddPictureAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    //MARK: - Post timeline action
    @IBAction func onPostAction(_ sender: UIButton) {
    }

}

