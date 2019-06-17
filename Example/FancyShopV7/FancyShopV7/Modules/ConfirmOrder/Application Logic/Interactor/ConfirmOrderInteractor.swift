//
//  ConfirmOrderInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// ConfirmOrderInteractor implements ConfirmOrderInteractorInputProtocol protocol, handles the interaction get the payment data and confirm the order with that information
class ConfirmOrderInteractor: ConfirmOrderInteractorInputProtocol {
    
    // MARK: Variables
    
    /// ConfirmOrderInteractorOutputProtocol optional instance
    weak var presenter: ConfirmOrderInteractorOutputProtocol?
    
    /// ConfirmOrderAPIDataManagerInputProtocol optional instance
    var APIDataManager: ConfirmOrderAPIDataManagerInputProtocol?
    
    /// ConfirmOrderLocalDataManagerInputProtocol optional instance
    var localDatamanager: ConfirmOrderLocalDataManagerInputProtocol?
    
    /// PaymentData optional instance
    var paymentData: PaymentData? = nil
    
    // MARK: Initializers
    
    
    /// Initializer that gets a PaymentData instance
    ///
    /// - Parameter withPaymentData: PaymentData Can be null
    init(withPaymentData:PaymentData?) {
        self.paymentData = withPaymentData
    }
    
    
    /// MARK: ConfirmOrderInteractorInputProtocol
    
    
    /// Retrieves the items in the shopping cart and pass them to the presenter, it also calls the method to get the total's and show them in the screen
    func getItemsOnShoppingCart() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.callShoppingTotalizers()
    }
    
    /// Gets the payment data and handles the server response, if it is a success, it will show the payment data, otherwise will tell the presenter to show an error
    func getPaymentData() {
        if let paymentDataSafe = self.paymentData{
            self.presenter?.got(paymentData: paymentDataSafe)
            self.presenter?.set(shippingStatus: SDKConfiguration.sharedInstance.suppressShipping)
            self.presenter?.set(orderNumber: ShoppingCart.sharedInstance.cartId)
        }else{
            self.APIDataManager?.getPaymentData(){ responseObject, error in
                let status: String = responseObject?.value(forKey: "status") as! String
                DispatchQueue.main.async {
                    if status == Constants.status.OK {
                        self.presenter?.got(paymentData: responseObject?.value(forKey: "data") as! PaymentData)
                        self.presenter?.set(shippingStatus: SDKConfiguration.sharedInstance.suppressShipping)
                        self.presenter?.set(orderNumber: ShoppingCart.sharedInstance.cartId)
                    } else {
                        self.presenter?.showPaymentDataNotFoundError()
                    }
                }
            }
        }
    }
    
    /// Calls the APIDataManager to confirm and place the order
    func confirmOrder() {
        self.APIDataManager?.confirmOrder(){ responseObject, error in
            let status: String = responseObject?.value(forKey: "status") as! String
            if status == Constants.status.OK{
                self.presenter?.postbackDone()
            }else {
                self.presenter?.showConfirmOrderFailedError()
            }
        }
    }
    
    /// Tells the presenter to show the total, subtotal and taxes values
    fileprivate func callShoppingTotalizers(){
        let shoppingCart = ShoppingCart.sharedInstance
        self.presenter?.set(taxes: shoppingCart.taxes)
        self.presenter?.set(subtotal: shoppingCart.subtotal)
        self.presenter?.set(total: shoppingCart.total)
    }
}
