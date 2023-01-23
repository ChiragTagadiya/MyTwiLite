//
//  MyTwiLiteViewController.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import UIKit
import NVActivityIndicatorView

class MyTwiLiteViewController: UIViewController, NVActivityIndicatorViewable {
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
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: MyTwiLiteStrings.okTitle, style: .default)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true)
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
    
    // MARK: - Show/ Hide loader
    func showLoader(_ message: String = "", _ color: UIColor = .darkGray, textColor: UIColor = .white) {
        let size = CGSize(width: 40, height: 40)
        startAnimating(size, message: message, type: .lineSpinFadeLoader, color: color,
                       backgroundColor: .lightGray.withAlphaComponent(0.3), textColor: textColor)
    }
    
    func hideLoader() {
        stopAnimating()
    }
}
