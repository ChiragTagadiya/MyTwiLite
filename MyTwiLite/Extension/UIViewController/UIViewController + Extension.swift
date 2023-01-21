//
//  UIViewController + Extension.swift
//  MyTwiLite
//
//  Created by DC on 19/01/23.
//

import UIKit

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func initiateFrom(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
