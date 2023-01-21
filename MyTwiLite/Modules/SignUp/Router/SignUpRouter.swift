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
            let loginViewController = LoginViewController.initiateFrom(appStoryboard: .logIn)
            context.navigationController?.pushViewController(loginViewController, animated: true)
        case .dashboard:
            let dashboardViewController = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
            context.navigationController?.pushViewController(dashboardViewController, animated: true)
        case .forgotPassword:
            break
        }
    }
}
