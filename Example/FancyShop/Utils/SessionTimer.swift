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

/// SessionTimer start,stop and count session time
class  SessionTimer: NSObject {
    
    var Counter : Double = 0
    var TimerScheduler = Timer()
    
    /// Singleton instance of Timer
    static let sharedInstance : SessionTimer = {
        let instance = SessionTimer()
        return instance
    }()
    
    //Start Counting Timer Count
    func startTimer() {
        self.Counter = 0
       
        if(!self.TimerScheduler.isValid) {
            self.TimerScheduler = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.IncreaseTimerCount), userInfo: nil, repeats: true)
            
        }
    }
    
    //Stop Counting Timer Count
    func stopTimer() {
        self.TimerScheduler.invalidate()
    }
    
    //Increase count of time by 1 sec
    @objc func IncreaseTimerCount() {
        self.Counter = self.Counter + 1
        
        if self.getTimeInMinute() >= Constants.checkoutSessionTimeout {
            DispatchQueue.main.async {
                self.stopTimer()
                LifeCycleObserver.sharedInstance.removeSessionNotification()
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            }
        }
        print(self.Counter)
    }
    
    func getTimeInMinute() -> Int {
        return Int(self.Counter/60)
    }
}
