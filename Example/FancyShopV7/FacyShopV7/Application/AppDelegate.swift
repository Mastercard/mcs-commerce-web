//
//  AppDelegate.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 9/25/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import UIKit
import MCSCommerceWeb

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Window instance, used by the navigation helper
    var window: UIWindow?
    
    // MARK: Methods
    
    ///  Override point for customization after application launch.
    ///
    /// - Parameters:
    ///   - application:
    ///   - launchOptions:
    /// - Returns:
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ProductListWireFrame.presentProductListModule(fromView: self)
        
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
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if MCCMerchant.handleMasterpassResponse(url.absoluteString, delegate: MasterpassSDKManager.sharedInstance) {
            //TODO:Remove below comment when checkoutdata service is working
            //CallbackResponseHandlerManager.handle(checkoutResponse: CheckoutResponse.sharedInstance, withSDKManager: MasterpassSDKManager.sharedInstance)
        }
        return true
    }
    
    
}

