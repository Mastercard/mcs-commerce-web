//
//  TransactionCompletePresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class TransactionCompletePresenter: TransactionCompletePresenterProtocol, TransactionCompleteInteractorOutputProtocol {
    
    // MARK: Varaiables
    weak var view: TransactionCompleteViewProtocol?
    var interactor: TransactionCompleteInteractorInputProtocol?
    var wireFrame: TransactionCompleteWireFrameProtocol?
    
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    
    // MARK: TransactionCompletePresenterProtocol
    
    /// Fetches the item from the shopping cart
    func fetchItemsFromShoppingCart() {
        self.interactor?.getItemsOnShoppingCart()
    }
    
    /// Ask for the payment data
    func getPaymentData() {
        self.interactor?.getPaymentData()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        self.wireFrame?.goBackToProductList(animated: animated)
    }
    
    // MARK: TransactionCompleteInteractorOutputProtocol
    
    /// Items fetched from the cart, passed to the view
    ///
    /// - Parameter items: ShoppingCartItem array
    func itemsFetched(items: [ShoppingCartItem]) {
        self.view?.showItemsInCart(items: items)
    }
    
    /// Goes back to the shopping cart
    func goBackToShoppingCart() {
        self.wireFrame?.goBackToProductList(animated: true)
    }
    
    /// Set the taxes
    ///
    /// - Parameter taxes: Taxes value
    func set(taxes: Double) {
        self.view?.set(taxes: SDKConfiguration.sharedInstance.getCurrencySymbol() + String(taxes))
    }
    
    /// Set the subtotal
    ///
    /// - Parameter taxes: subtotal value
    func set(subtotal: Double) {
        self.view?.set(subtotal: SDKConfiguration.sharedInstance.getCurrencySymbol() + String(subtotal))
    }
    
    /// Set the total
    ///
    /// - Parameter taxes: total value
    func set(total: Double) {
        self.view?.set(total: SDKConfiguration.sharedInstance.getCurrencySymbol() + String(total))
    }
    
    /// Shows an error in the view
    ///
    /// - Parameter error: String with the error
    func show(error: String) {
        self.view?.showError(message: error)
    }
    
    /// Passes the payment data to the view
    ///
    /// - Parameter paymentData: Payment data object
    func got(paymentData: PaymentData) {
        self.view?.set(shippingAddress: paymentData.shippingAddress!.getFullAddress(withBreakLines: true))
        self.view?.set(cardNumber: paymentData.getDisplayCardNumber()!)
    }
    
    /// Calls the interator to confirm the order
    func orderConfirmed() {
        self.interactor?.orderConfirmed()
    }
    
    /// Sets the suppress shipping flag
    ///
    /// - Parameter shippingStatus: Supress shipping status flag
    func set(shippingStatus: Bool) {
        self.view?.set(shippingStatus: shippingStatus)
    }
    
    /// Sets the order number to be shown in the view
    ///
    /// - Parameter orderNumber: String with the order number
    func set(orderNumber: String) {
        self.view?.set(orderNumber: orderNumber)
    }
}
