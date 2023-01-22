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
    
    func showAlert(message: String) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true)
    }
    
    // MARK: - Show/ Hide loader
    func showLoader(_ message: String = "", _ color: UIColor = .darkGray, textColor: UIColor = .white) {
        let size = CGSize(width: 40, height: 40)
        startAnimating(size, message: message, type: .lineSpinFadeLoader, color: color,
                       backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), textColor: textColor)
    }
    
    func hideLoader() {
        stopAnimating()
    }
}
