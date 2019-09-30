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

/// DataPersisterManager handles the persistency in the disk
class DataPersisterManager: NSObject {
    // MARK: variables
    
    /// Singleton instance
    static let sharedInstance = DataPersisterManager()
    
    let kConfiguration = "Configuration"
    let kShoppingCart = "ShoppingCart"
    let kUser = "User"
    let kPaymentMethod = "paymentMethod"
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    // MARK: methods
    
    
    /// Saves the configuration object in the UserDefaults
    func saveConfiguration(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:SDKConfiguration.sharedInstance), forKey: kConfiguration)
    }
    
    
    /// Returns the configuration saved in the disk if exists, otherwise will return nil
    func getConfiguration() -> SDKConfiguration?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: kConfiguration) as? NSData{

            return NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? SDKConfiguration
        }
        return nil
    }
    
    /// Saves the shopping cart object in the UserDefaults
    func saveShoppingCart(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:ShoppingCart.sharedInstance), forKey: kShoppingCart)
    }
    
    
    /// Returns the shopping cart saved in the disk if exists, otherwise will return nil
    func getShoppingCart() -> ShoppingCart?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: kShoppingCart) as? NSData{

            return NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? ShoppingCart
        }
        return nil
    }
    
    
    /// Saves the User object in the UserDefaults
    func saveUser(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:User.sharedInstance), forKey: kUser)
    }
    
    
    /// Returns the user in the disk if exists, otherwise will return nil
    func getUser() -> User?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: kUser) as? NSData{

            return NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? User
        }
        return nil
    }
    
    /// Saves the paymentMethod object in the UserDefaults
    func savePaymentMethod(){
    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:PaymentMethod.sharedInstance), forKey: kPaymentMethod)
        UserDefaults.standard.synchronize();
    }
    
    /// Removes the PaymentMethod object in UserDefaults
    func removePaymentMethod(){
        if UserDefaults.standard.data(forKey: kPaymentMethod) != nil {
            UserDefaults.standard.removeObject(forKey: kPaymentMethod)
            UserDefaults.standard.synchronize();
        }
    }
    
    /// Returns the paymentMethod in the disk if exists, otherwise will return nil
    func getPaymentMethod() -> PaymentMethod? {
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: kPaymentMethod) as? NSData{
            if let paymentMethod = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? PaymentMethod {
                return paymentMethod
            }
        }
        return nil
    }
}
