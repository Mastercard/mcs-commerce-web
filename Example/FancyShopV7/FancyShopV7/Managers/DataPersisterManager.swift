//
//  DataPersisterManager.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/12/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// DataPersisterManager handles the persistency in the disk
class DataPersisterManager: NSObject {
    // MARK: variables
    
    /// Singleton instance
    static let sharedInstance = DataPersisterManager()
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    // MARK: methods
    
    
    /// Saves the configuration object in the UserDefaults
    func saveConfiguration(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:SDKConfiguration.sharedInstance), forKey: "Configuration")
    }
    
    
    /// Returns the configuration saved in the disk if exists, otherwise will return nil
    func getConfiguration() -> SDKConfiguration?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: "Configuration") as? NSData{
            if let configuration = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? SDKConfiguration{
                return configuration
            }
        }
        return nil
    }
    
    /// Saves the shopping cart object in the UserDefaults
    func saveShoppingCart(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:ShoppingCart.sharedInstance), forKey: "ShoppingCart")
    }
    
    
    /// Returns the shopping cart saved in the disk if exists, otherwise will return nil
    func getShoppingCart() -> ShoppingCart?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: "ShoppingCart") as? NSData{
            if let shoppingCart = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? ShoppingCart{
                return shoppingCart
            }
        }
        return nil
    }
    
    
    /// Saves the User object in the UserDefaults
    func saveUser(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:User.sharedInstance), forKey: "User")
    }
    
    
    /// Returns the user in the disk if exists, otherwise will return nil
    func getUser() -> User?{
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: "User") as? NSData{
            if let user = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? User{
                return user
            }
        }
        return nil
    }
    
    /// Saves the paymentMethod object in the UserDefaults
    func savePaymentMethod(){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:PaymentMethod.sharedInstance), forKey: "paymentMethod")
        UserDefaults.standard.synchronize();
    }
    
    /// Removes the PaymentMethod object in UserDefaults
    func removePaymentMethod(){
        if UserDefaults.standard.data(forKey: "paymentMethod") != nil {
            UserDefaults.standard.removeObject(forKey: "paymentMethod")
            UserDefaults.standard.synchronize();
        }
    }
    
    /// Returns the paymentMethod in the disk if exists, otherwise will return nil
    func getPaymentMethod() -> PaymentMethod? {
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: "paymentMethod") as? NSData{
            if let paymentMethod = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? PaymentMethod {
                return paymentMethod
            }
        }
        return nil
    }
}
