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

import Foundation

/// LifeCycleObserver add session when checkout button clicked, remove session when failuer or success. For checkout session time tracking.
class LifeCycleObserver : NSObject {

    /// Singleton instance of Timer
    static let sharedInstance : LifeCycleObserver = {
        let instance = LifeCycleObserver()
        return instance
    }()
    
    /// Notification Method when app comes in forground
    @objc func applicationWillEnterForeground() {
        
        let currentSessionTime = SessionTimer.sharedInstance.getTimeInMinute()
        if  currentSessionTime >= Constants.checkoutSessionTimeout {
            DispatchQueue.main.async {
                self.removeSessionNotification()
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    /// Adding background notification for session.
    func addSessionNotification() {
        NotificationCenter.default.addObserver(LifeCycleObserver.sharedInstance, selector: #selector(LifeCycleObserver.sharedInstance.applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /// Remove notifications.
    func removeSessionNotification() {
        SessionTimer.sharedInstance.stopTimer()
        NotificationCenter.default.removeObserver(self, name:UIApplication.willEnterForegroundNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name:UIApplication.didEnterBackgroundNotification , object: nil)
    }
}

