//
//  NavigationHelper.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/7/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Used to do all the pushes and pops
class NavigationHelper{
    
    /// Sets the root view controller
    ///
    /// - Parameter withViewController: View controller to set as root view controller
    static func setRootViewController(withViewController: UIViewController){
        let navigationController = UINavigationController(rootViewController: withViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    /// Pushes a new view controller to the navigation controller
    ///
    /// - Parameter viewController: UIViewController to be pushed
    static func pushViewController(viewController: UIViewController){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Makes a pop of the current view, to go the previous screen
    ///
    /// - Parameter animated: animated flag
    static func singleBack(animated: Bool){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popViewController(animated: animated)
    }
    
    /// Pops all views until the root view controller
    ///
    /// - Parameter animated: animation flag
    static func popToRootViewController(animated: Bool){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: animated)
    }
    
    
    /// Presents a view controller using the top view controller as a presenter
    ///
    /// - Parameter viewController: UIViewController to be presented
    static func presentViewController(viewController: UIViewController){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.present(viewController, animated: true, completion: {})
    }
}
