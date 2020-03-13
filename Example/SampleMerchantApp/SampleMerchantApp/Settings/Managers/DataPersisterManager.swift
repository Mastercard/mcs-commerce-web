//
//  DataPersisterManager.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/17/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

/// DataPersisterManager handles the persistency in the disk
class DataPersisterManager: NSObject {
    // MARK: variables
    
    /// Singleton instance
    static let sharedInstance = DataPersisterManager()
    
    let kConfiguration = "Configuration"
    let kUser = "User"
    let kPaymentMethod = "paymentMethod"
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
    }
    
    // MARK: methods
    
    
    /// Saves the configuration object in the UserDefaults
    func saveConfiguration() {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject:SDKConfiguration.sharedInstance), forKey: kConfiguration)
    }
    
    
    /// Returns the configuration saved in the disk if exists, otherwise will return nil
    func getConfiguration() -> SDKConfiguration? {
        let ud = UserDefaults.standard
        if let decodedNSData = ud.object(forKey: kConfiguration) as? NSData{

            return NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? SDKConfiguration
        }
        return nil
    }
    
    func getRandomCartId(length: Int) -> String {
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func getRandomAmount() -> NSDecimalNumber {
        let randomDouble = Double.random(in: 1..<100)
        let randomDoubleRounded = String(format: "%.2f", randomDouble)
        return NSDecimalNumber(string: randomDoubleRounded)
    }
}
