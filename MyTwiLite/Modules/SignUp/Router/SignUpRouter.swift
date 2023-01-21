//
//  SignUpRouter.swift
//  MyTwiLite
//
//  Created by DC on 21/01/23.
//

import Foundation
import UIKit

class SignUpRouter: Router {
    
    enum Destination {
        case logIn
        case dashboard
        case forgotPassword
    }
    
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .logIn:
            let loginVC = LoginViewController.initiateFrom(appStoryboard: .logIn)
            context.navigationController?.pushViewController(loginVC, animated: true)
        case .dashboard:
            let dashboardVC = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
            context.navigationController?.pushViewController(dashboardVC, animated: true)
        case .forgotPassword:
            break
        }
    }
}
