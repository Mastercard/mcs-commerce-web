//
//  AppDelegate.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/16/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    /// Handles the URL if the apps is awake from a URL Scheme
    ///
    /// - Parameters:
    ///   - application:
    ///   - url:
    ///   - sourceApplication:
    ///   - annotation:
    /// - Returns:
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    

}

