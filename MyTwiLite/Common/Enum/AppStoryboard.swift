//
//  AppStoryboard.swift
//  MyTwiLite
//
//  Created by DC on 19/01/23.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case launch
    case signUp
    case logIn
    case dashboard
    case addTimeline
    
    var instance: UIStoryboard {
        let capitalizedString = self.rawValue.capitalizedFirstLetter
        return UIStoryboard(name: capitalizedString, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }
    
    public func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
