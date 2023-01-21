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
            let loginVC = LoginViewController.initiateFrom(appStoryboard: .logIn)
            context.navigationController?.pushViewController(loginVC, animated: false)
        case .dashboard:
            let dashboardVC = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
            context.navigationController?.pushViewController(dashboardVC, animated: false)
        case .signUp:
            let signUpVC = SignUpViewController.initiateFrom(appStoryboard: .signUp)
            context.navigationController?.pushViewController(signUpVC, animated: false)
        }
    }
    
}
