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

/// PaymentMethodsInteractor implements PaymentMethodsInteractorInputProtocol protocol, handles the interaction to show the payment methods and enable the masterpass pairing flow
class PaymentMethodsInteractor:BaseInteractor, PaymentMethodsInteractorInputProtocol {
    
    
    /// MARK: variables
    weak var presenter: PaymentMethodsInteractorOutputProtocol?
    var APIDataManager: PaymentMethodsAPIDataManagerInputProtocol?
    var localDatamanager: PaymentMethodsLocalDataManagerInputProtocol?
    fileprivate var paymentMethods: [NSDictionary]?
    fileprivate var isComingBackFromLogin: Bool = false
    
    // MARK: PaymentMethodsInteractorInputProtocol
    
    /// Gets the payment methods and the user information
    func fetchPaymentMethods() {
        self.presenter?.setPaymentMethods(paymentMethods: self.getPaymentMethods())
    }
    
    /// Shows the pairing flow if the user selects 'masterpass' as a payment method
    ///
    /// - Parameter method: String with the method selected
    func paymentMethodSelected(method: String) {
        //let user: User = User.sharedInstance
        if method == Constants.paymentMethods.masterpass {
            if PaymentMethod.sharedInstance.paymentMethodObject != nil {
                PaymentMethod.sharedInstance.removePaymentMethod()
            } else {
                PaymentMethod.sharedInstance.savePaymentMethod()
            }
        }
    }
    
    /// Checks if the user is logged in, if it is, it will save the selected payment method
    func checkIfJustLoggedIn() {
        let user: User = User.sharedInstance
        if self.isComingBackFromLogin && user.isLoggedIn() {
            self.isComingBackFromLogin = false
            self.paymentMethodSelected(method: Constants.paymentMethods.masterpass)
        }
    }
    
    
    /// Returns an array of payment methods
    ///
    /// - Returns: NSDictionary array
    fileprivate func getPaymentMethods() -> [NSDictionary]{
        
        if self.paymentMethods == nil{
            self.paymentMethods = []
            for paymentMethod in Constants.paymentMethods.allValues {
                let paymentMethodDict = NSMutableDictionary.init()
                paymentMethodDict.setValue(paymentMethod + "Image", forKey: "image")
                switch paymentMethod{
                case Constants.paymentMethods.masterpass:
                    paymentMethodDict.setValue(Constants.paymentMethods.masterpass, forKey: "name")
                case Constants.paymentMethods.SRCMark:
                    paymentMethodDict.setValue(Constants.paymentMethods.SRCMark, forKey: "name")
                case Constants.paymentMethods.paypal:
                    paymentMethodDict.setValue(Constants.paymentMethods.paypal, forKey: "name")
                case Constants.paymentMethods.addPaymentMethod:
                    paymentMethodDict.setValue(Constants.paymentMethods.addPaymentMethod, forKey: "name")
                    paymentMethodDict.setValue("addPaymentMethodImage", forKey: "image")
                default:
                    paymentMethodDict.setValue("", forKey: "name")
                }
                self.paymentMethods?.append(paymentMethodDict)
            }
        }
        return self.paymentMethods!
    }
}
