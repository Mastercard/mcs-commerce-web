//
//  PaymentMethod.swift
//  MerchantApp
//
//  Created by Patel, Utkal on 1/24/18.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb

/// PaymentMethod object, handles the paymentMethod info after paymentMethod set by user.
class PaymentMethod: NSObject, NSCoding {
    
    var paymentMethodObject : MCCPaymentMethod?
    
    /// Singleton instance
    static let sharedInstance : PaymentMethod = {
        if let instance = DataPersisterManager.sharedInstance.getPaymentMethod() {
            return instance
        }
        return PaymentMethod()
    }()
    
    // MARK: Initializers
    /// Private intitializer
    private override init() {
        super.init()
    }
    
    // MARK: Methods
    /// Saves the PaymentMethod
    func savePaymentMethod(){
        DataPersisterManager.sharedInstance.savePaymentMethod()
    }
    
    /// Removes the PaymentMethod
    func removePaymentMethod(){
        DataPersisterManager.sharedInstance.removePaymentMethod()
        self.paymentMethodObject = nil
    }
    
    //MARK: NSCoding
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    internal required init?(coder aDecoder: NSCoder) {
        self.paymentMethodObject = aDecoder.decodeObject(forKey: "paymentMethodObject") as? MCCPaymentMethod
        super.init()
    }
    
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.paymentMethodObject, forKey:"paymentMethodObject")
    }
}
