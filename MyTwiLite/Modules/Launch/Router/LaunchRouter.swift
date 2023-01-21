//
//  LaunchRouter.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

class LaunchRouter: Router {
    
    enum Destination {
        case login
        case signUp
        case dashboard
    }
    
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .login:
            let loginVC = LoginViewController()
            context.navigationController?.pushViewController(loginVC, animated: true)
        case .dashboard:
            break
        case .signUp:
            let signUpVC = SignUpViewController()
            context.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
}
