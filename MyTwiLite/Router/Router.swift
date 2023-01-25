//
//  Router.swift
//  MyTwiLite
//
//  Created by DC on 19/01/23.
//

import Foundation
import UIKit

// MARK: - App level router protocol
protocol Router {
    associatedtype Destination
    func route(to destination: Destination, from context: UIViewController, parameters: Any?)
}
