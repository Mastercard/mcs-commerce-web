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
        self.view?.set(taxes: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", taxes))
    }
    
    /// Set the subtotal
    ///
    /// - Parameter subtotal: subtotal value
    func set(subtotal: Double) {
        self.view?.set(subtotal: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", subtotal))
    }
    
    /// Set the total
    ///
    /// - Parameter total: total value
    func set(total: Double) {
        self.view?.set(total: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", total))
    }
    
    /// Set the total
    ///
    /// - Parameter shippingAddress: shipping address value
    func set(shippingAddress: String) {
       self.view?.set(shippingAddress: shippingAddress)
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
        self.view?.set(shippingAddress: paymentData.shippingAddress!.getFullAddress(withBreakLines: false))
        self.view?.set(cardNumber: paymentData.getDisplayCardNumber()!)
    }
    
    /// Calls the interator to confirm the order
    func orderConfirmed() {
        self.interactor?.orderConfirmed()
    }
    
    /// Sets the order number to be shown in the view
    ///
    /// - Parameter orderNumber: String with the order number
    func set(orderNumber: String) {
        self.view?.set(orderNumber: orderNumber)
    }
}
