//
//  PaymentMethodsInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
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
        self.presenter?.setUser(hasPairingId: User.sharedInstance.userHasPairingId())
        self.presenter?.setUser(hasTransactionPairingId: User.sharedInstance.userHasTransactionPairingId())
    }
    
    /// Shows the pairing flow if the user selects 'masterpass' as a payment method
    ///
    /// - Parameter method: String with the method selected
    func paymentMethodSelected(method: String) {
        
        if method == Constants.paymentMethods.masterpass {
            MCCMerchant.addMasterpassPaymentMethod(MasterpassSDKManager.sharedInstance, withCompletionBlock: { (paymentMethod: MCCPaymentMethod?, error:Error?) -> (Void) in
                
                if (error != nil) {
                    print(error?.localizedDescription as Any);
                    if ((error! as NSError).code == MCCMerchantErrorCode.MCCInternalError.rawValue) {
                        self.presenter?.showSDKAddPaymentMethodError(error: error!)
                    }
                }
                else {
                    let paymentMethodInstance = PaymentMethod.sharedInstance
                    paymentMethodInstance.paymentMethodObject = paymentMethod
                    paymentMethodInstance.savePaymentMethod()
                    if let pairingTransactionID = paymentMethod?.pairingTransactionID {
                        let user: User = User.sharedInstance
                        user.pairingId = nil
                        user.pairingTransactionId = pairingTransactionID
                        user.saveUser()
                    }
                    self.presenter?.setAddedPaymentMethod(paymentMethod: paymentMethodInstance)
                }
            })
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
