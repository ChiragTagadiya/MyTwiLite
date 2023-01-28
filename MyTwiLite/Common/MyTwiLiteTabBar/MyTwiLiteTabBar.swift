//
//  MyTwiLiteTabBar.swift
//  MyTwiLite
//
//  Created by DC on 24/01/23.
//

import Foundation
import UIKit

class MyTwiLiteTabBar {
    // MARK: - initiate tabbar
    func initiateTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Colors.green
        
        let dashboardViewController = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
        let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
        let dashbordTabBarItem = UITabBarItem(title: MyTwiLiteStrings.timelines,
                                              image: UIImage(named: MyTwiLiteKeys.dashBoardIcon), tag: 0)
        dashboardNavigationController.tabBarItem = dashbordTabBarItem
        
        let myTimelineViewController = DashboardViewController.initiateFrom(appStoryboard: .dashboard)
        myTimelineViewController.viewModel.isMyTimline = true
        myTimelineViewController.viewModel.deleteTimelineDelegate = dashboardViewController.self
        let myTimelineNavigationController = UINavigationController(rootViewController: myTimelineViewController)
        let myTimeLineTabBarItem = UITabBarItem(title: MyTwiLiteStrings.myTimeline,
                                                image: UIImage(named: MyTwiLiteKeys.myTimelineIcon), tag: 1)
        myTimelineNavigationController.tabBarItem = myTimeLineTabBarItem
        
        let profileViewController = ProfileViewController.initiateFrom(appStoryboard: .profile)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let profileTabBarItem = UITabBarItem(title: MyTwiLiteStrings.profile,
                                             image: UIImage(named: MyTwiLiteKeys.profileIcon), tag: 2)
        profileNavigationController.tabBarItem = profileTabBarItem

        tabBarController.viewControllers = [
            dashboardNavigationController,
            myTimelineNavigationController,
            profileNavigationController
        ]
        return tabBarController
    }
}
