//
//  ProfileRouter.swift
//  MyTwiLite
//
//  Created by DC on 27/01/23.
//

import Foundation
import UIKit

class ProfileRouter: Router {
    
    enum Destination {
        case logIn
    }
    
    // MARK: - Handle routing
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .logIn:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let logInNavigationController = UINavigationController()
                let loginViewController = LoginViewController.initiateFrom(appStoryboard: .logIn)
                logInNavigationController.viewControllers = [loginViewController]
                sceneDelegate.window?.rootViewController = logInNavigationController
            }
        }
    }
}
