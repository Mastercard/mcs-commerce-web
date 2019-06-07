//
//  PreCheckoutDataInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// PreCheckoutDataInteractor implements PreCheckoutDataInteractorInputProtocol protocol, handles the interaction to show the precheckout data and do the express checkout
class PreCheckoutDataInteractor:BaseInteractor, PreCheckoutDataInteractorInputProtocol {
    
    
    // MARK: Variables
    weak var presenter: PreCheckoutDataInteractorOutputProtocol?
    var APIDataManager: PreCheckoutDataAPIDataManagerInputProtocol?
    var localDatamanager: PreCheckoutDataLocalDataManagerInputProtocol?
    var preCheckoutData: PreCheckoutData?
    
    
    /// Calls the API to get the precheckout data and parse it
    func fetchPreCheckoutData() {
        if NetworkReachability.isNetworkRechable() {
            self.APIDataManager?.getPreCheckoutData(){ response, error in
                let status: String = response?.value(forKey: "status") as! String
                if status == Constants.status.OK{
                    let user:User = User.sharedInstance
                    let checkoutResponse:CheckoutResponse = CheckoutResponse.sharedInstance
                    if let preCheckoutTransactionId = response?.value(forKeyPath: "data.preCheckoutTransactionId") {
                        var preCheckoutData: PreCheckoutData = PreCheckoutData(cards: [], shippingAddresses: [], preCheckoutTransactionId: preCheckoutTransactionId as! String)
                        user.pairingId = response?.value(forKeyPath: "data.pairingId") as? String
                        user.saveUser()
                        
                        let cardArrayResponse = response?.value(forKeyPath: "data.cards") as! [NSDictionary]
                        for cardDict:NSDictionary in cardArrayResponse {
                            var card:Card = Card()
                            card.brandName = cardDict.value(forKey: "brandName") as? String
                            card.cardHolderName = cardDict.value(forKey: "cardHolderName") as? String
                            card.cardId = cardDict.value(forKey: "cardId") as? String
                            card.expiryMonth = "\(cardDict.value(forKey: "expiryMonth")!)"
                            card.expiryYear = "\(cardDict.value(forKey: "expiryYear")!)"
                            card.lastFour = "\(cardDict.value(forKey: "lastFour")!)"
                            preCheckoutData.cards.append(card)
                        }
                        
                        if let addressArrayResponse = response?.value(forKeyPath: "data.shippingAddresses") as? [NSDictionary] {
                            for addressDict:NSDictionary in addressArrayResponse {
                                var address: ShippingAddress = ShippingAddress()
                                address.addressId = addressDict.value(forKey: "addressId") as? String
                                address.city = addressDict.value(forKey: "city") as? String
                                address.country = addressDict.value(forKey: "country") as? String
                                address.line1 = addressDict.value(forKey: "line1") as? String
                                address.line2 = addressDict.value(forKey: "line2") as? String
                                address.line3 = addressDict.value(forKey: "line3") as? String
                                address.line4 = addressDict.value(forKey: "line4") as? String
                                address.line5 = addressDict.value(forKey: "line5") as? String
                                address.postalCode = addressDict.value(forKey: "postalCode") as? String
                                address.subdivision = addressDict.value(forKey: "subdivision") as? String
                                address.addressId = addressDict.value(forKey: "addressId") as? String
                                
                                preCheckoutData.shippingAddresses.append(address)
                            }
                        }
                        self.preCheckoutData = preCheckoutData
                        checkoutResponse.transactionId = preCheckoutTransactionId as? String
                        self.presenter?.present(preCheckoutData: preCheckoutData)
                    }else{
                        self.presenter?.showPreCheckoutDataError()
                    }
                }else {
                    self.presenter?.showPreCheckoutDataError()
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
    
    /// Calls OneServer to do the express checkout with the selected card and shipping address
    ///
    /// - Parameters:
    ///   - card: selected card
    ///   - shippingAddress: selected shipping address
    func expressCheckout(card: Card, shippingAddress: ShippingAddress?,suppressShipping:Bool) {
        if NetworkReachability.isNetworkRechable() {
            self.APIDataManager?.doExpressCheckout(preCheckoutTransactionId: (self.preCheckoutData?.preCheckoutTransactionId)!, card: card, shippingAddress: shippingAddress,suppressShipping:suppressShipping){ response, error in
                let status: String = response?.value(forKey: "status") as! String
                if status == Constants.status.OK{
                    if let pairingId = response?.value(forKeyPath: "data.pairingId"){
                        let user:User = User.sharedInstance
                        user.pairingId = pairingId as? String
                        user.saveUser()
                        self.presenter?.expressCheckoutDone(paymentData: PaymentData.sharedInstance)
                    }else{
                        self.presenter?.showExpressCheckoutError()
                    }
                }else {
                    self.presenter?.showExpressCheckoutError()
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
}
