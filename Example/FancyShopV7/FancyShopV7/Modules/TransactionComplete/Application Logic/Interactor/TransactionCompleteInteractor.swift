//
//  TransactionCompleteInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// TransactionCompleteInteractor implements TransactionCompleteInteractorInputProtocol protocol, handles the interaction to show the order summary and the right button to make the checkout
class TransactionCompleteInteractor: TransactionCompleteInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: TransactionCompleteInteractorOutputProtocol?
    var APIDataManager: TransactionCompleteAPIDataManagerInputProtocol?
    var localDatamanager: TransactionCompleteLocalDataManagerInputProtocol?
    
    //  MARK: initializers
    
    /// Base initiliazer
    init() {}
    
    // MARK: TransactionCompleteInteractorInputProtocol
    
    /// Gets the items from the cart and pass them to the presenter
    func getItemsOnShoppingCart() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.callShoppingTotalizers()
        self.presenter?.set(orderNumber: shoppingCart.cartId)
    }
    
    /// Passes the payment data
    func getPaymentData() {
        self.presenter?.got(paymentData: PaymentData.sharedInstance)
        self.presenter?.set(shippingStatus: SDKConfiguration.sharedInstance.suppressShipping)
    }
    
    /// Sets the taxes, subtotal and total
    fileprivate func callShoppingTotalizers(){
        let shoppingCart = ShoppingCart.sharedInstance
        self.presenter?.set(taxes: shoppingCart.taxes)
        self.presenter?.set(subtotal: shoppingCart.subtotal)
        self.presenter?.set(total: shoppingCart.total)
    }
    
    /// Empties the cart
    func orderConfirmed() {
        ShoppingCart.sharedInstance.emptyCart()
    }
}
