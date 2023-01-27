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
    }
    
    // MARK: - Handle routing
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .signUp:
            let signUpViewController = SignUpViewController.initiateFrom(appStoryboard: .signUp)
            context.navigationController?.pushViewController(signUpViewController, animated: true)
        case .dashboard:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let tabBarController = MyTwiLiteTabBar().initiateTabBar()
                sceneDelegate.window?.rootViewController = tabBarController
            }
        }
    }
}
