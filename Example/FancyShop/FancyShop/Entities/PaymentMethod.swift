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

/// Private Struct - PaymentMethod
private struct PaymentMethodStruct {
    static let kPaymentMethodObject = "paymentMethodObject"
}

/// PaymentMethod object, handles the paymentMethod info after paymentMethod set by user.
class PaymentMethod: NSObject, NSCoding {
    
    var paymentMethodObject : NSObject?
    
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
        self.paymentMethodObject = DataPersisterManager.sharedInstance.getPaymentMethod() 
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
        self.paymentMethodObject = aDecoder.decodeObject(forKey: PaymentMethodStruct.kPaymentMethodObject) as? NSObject
        super.init()
    }
    
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.paymentMethodObject, forKey:PaymentMethodStruct.kPaymentMethodObject)
    }
}
