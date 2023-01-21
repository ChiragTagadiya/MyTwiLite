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
        case logIn
        case signUp
        case dashboard
    }
    
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .logIn:
            let loginViewController = LoginViewController.initiateFrom(appStoryboard: .logIn)
            context.navigationController?.pushViewController(loginViewController, animated: false)
        case .dashboard:
            let dashboardViewController = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
            context.navigationController?.pushViewController(dashboardViewController, animated: false)
        case .signUp:
            let signUpViewController = SignUpViewController.initiateFrom(appStoryboard: .signUp)
            context.navigationController?.pushViewController(signUpViewController, animated: false)
        }
    }
    
}
