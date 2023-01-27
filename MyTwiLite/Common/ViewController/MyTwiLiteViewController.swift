//
//  MyTwiLiteViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit
import NVActivityIndicatorView
import Toast_Swift

class MyTwiLiteViewController: UIViewController, NVActivityIndicatorViewable {
    // MARK: - Hide/ Show navigation back buttone
    var shouldHideBackButton: Bool = false {
        didSet {
            self.navigationItem.hidesBackButton = shouldHideBackButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Show alert
    func showAlert(message: String) {
        self.view.makeToast(message)
    }
    
    // MARK: - Show custom alert to handle multiple actions
    func showCustomAlert(message: String, okCallback: @escaping ((UIAlertAction) -> Void)) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let noAction = UIAlertAction(title: MyTwiLiteStrings.noTitle, style: .cancel)
        let yesAction = UIAlertAction(title: MyTwiLiteStrings.yesTitle, style: .destructive, handler: okCallback)
        alertViewController.addAction(noAction)
        alertViewController.addAction(yesAction)
        
        self.present(alertViewController, animated: true)
    }
    
    // MARK: - Show loader
    func showLoader(_ message: String = "", _ color: UIColor = .darkGray, textColor: UIColor = .white) {
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: message, type: .lineSpinFadeLoader, color: color,
                       backgroundColor: .lightGray.withAlphaComponent(0.3), textColor: textColor)
    }
    
    // MARK: - Hide loader
    func hideLoader() {
        stopAnimating()
    }
}
