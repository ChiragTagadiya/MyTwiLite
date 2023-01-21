//
//  LogInRouter.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

class LogInRouter: Router {
    
    enum Destination {
        case signUp
        case dashboard
        case forgotPassword
    }
    
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .signUp:
            let signUpVC = SignUpViewController()
            context.navigationController?.pushViewController(signUpVC, animated: true)
        case .dashboard:
            break
        case .forgotPassword:
            break
        }
    }
}
