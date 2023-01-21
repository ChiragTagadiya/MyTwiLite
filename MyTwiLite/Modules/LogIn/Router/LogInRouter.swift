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
            let signUpVC = SignUpViewController.initiateFrom(appStoryboard: .signUp)
            context.navigationController?.pushViewController(signUpVC, animated: true)
        case .dashboard:
            let dashboardVC = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
            context.navigationController?.pushViewController(dashboardVC, animated: true)
        case .forgotPassword:
            break
        }
    }
}
