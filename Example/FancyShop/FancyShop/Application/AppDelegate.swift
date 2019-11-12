/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

import UIKit
import NVActivityIndicatorView
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
        
        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotatePulse
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(red:247, green: 158, blue: 27)
        NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 1000
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
        return true
    }
    
    
}

