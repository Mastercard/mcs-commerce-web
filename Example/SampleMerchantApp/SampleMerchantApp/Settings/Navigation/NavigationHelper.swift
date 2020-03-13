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

/// Used to do all the pushes and pops
class NavigationHelper {
    
    static let sharedInstance = NavigationHelper()
    
    private init() {}
    
    /// Sets the root view controller
    ///
    /// - Parameter withViewController: View controller to set as root view controller
    func setRootViewController(withViewController: UIViewController){
        let navigationController = UINavigationController(rootViewController: withViewController)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    /// Pushes a new view controller to the navigation controller
    ///
    /// - Parameter viewController: UIViewController to be pushed
    func pushViewController(viewController: UIViewController, animated: Bool){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    /// Makes a pop of the current view, to go the previous screen
    ///
    /// - Parameter animated: animated flag
    func singleBack(animated: Bool){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popViewController(animated: animated)
    }
    
    /// Pops all views until the root view controller
    ///
    /// - Parameter animated: animation flag
    func popToRootViewController(animated: Bool){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.popToRootViewController(animated: animated)
    }
    
    
    /// Presents a view controller using the top view controller as a presenter
    ///
    /// - Parameter viewController: UIViewController to be presented
    func presentViewController(viewController: UIViewController){
        let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        navigationController.present(viewController, animated: true, completion: {})
    }
}
