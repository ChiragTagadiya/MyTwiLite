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
    }
    
    // MARK: - Handle routing
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .logIn:
            context.navigationController?.popViewController(animated: true)
        case .dashboard:
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let tabBarController = MyTwiLiteTabBar().initiateTabBar()
                sceneDelegate.window?.rootViewController = tabBarController
            }
        }
    }
}
