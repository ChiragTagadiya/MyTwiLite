//
//  DashboardRouter.swift
//  MyTwiLite
//
//  Created by DC on 22/01/23.
//

import Foundation
import UIKit

class DashboardRouter: Router {
    enum Destination {
        case addTimeline
    }
    
    // MARK: - Handle routing
    func route(to destination: Destination, from context: UIViewController, parameters: Any?) {
        switch destination {
        case .addTimeline:
            let addTimelineViewController = AddTimelineViewController.initiateFrom(appStoryboard: .addTimeline)
            context.navigationController?.present(addTimelineViewController, animated: true)
        }
    }
}
