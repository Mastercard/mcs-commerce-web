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
class ConfirmOrderPresenter:BasePresenter, ConfirmOrderPresenterProtocol, ConfirmOrderInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: ConfirmOrderViewProtocol?
    var interactor: ConfirmOrderInteractorInputProtocol?
    var wireFrame: ConfirmOrderWireFrameProtocol?
    let stringsTableName = "ConfirmOrder"
    
    
    /// Goes back to the product list
    ///
    /// - Parameter animated: animation flag
    func goBackToProductList(animated: Bool) {
        self.wireFrame?.goBackToProductList(animated: animated)
    }
    
    // MARK: ConfirmOrderPresenterProtocol
    
    /// Tells the interactor to fetch the items on the shopping cart
    func fetchItemsFromShoppingCart() {
        self.interactor?.getItemsOnShoppingCart()
    }
    
    /// Ask the interactor to get the payment data for the current checkout
    func getPaymentData() {
        self.interactor?.getPaymentData()
    }
    
    /// Ask the interactor to confirm the order for the current checkout and payment data
    func confirmOrderAction() {
        self.interactor?.confirmOrder()
    }
    
    // MARK: ConfirmOrderInteractorOutputProtocol
    
    /// Called from the interactor, tells the presenter that the shopping items has been fetched
    ///
    /// - Parameter items: ShoppingCartItem array
    func itemsFetched(items: [ShoppingCartItem]) {
        self.view?.showItemsInCart(items: items)
    }
    
    /// Goes back to the shopping cart view
    func goBackToShoppingCart() {
        self.wireFrame?.goBackToProductList(animated: true)
    }
    
    /// Tells the view to set the taxes
    ///
    /// - Parameter taxes: Double value with the taxes
    func set(taxes: Double) {
        self.view?.set(taxes: Constants.currencySymbol.currentSymbol + String(taxes))
    }
    
    /// Tells the view to set the subtotal
    ///
    /// - Parameter taxes: Double value with the subtotal
    func set(subtotal: Double) {
        self.view?.set(subtotal: Constants.currencySymbol.currentSymbol + String(subtotal))
    }
    /// Tells the view to set the total
    ///
    /// - Parameter taxes: Double value with the total
    func set(total: Double) {
        self.view?.set(total: Constants.currencySymbol.currentSymbol + String(total))
    }
    
    /// Called when an error happens while getting the payment data information, it gets the error message from the strings file
    func showPaymentDataNotFoundError() {
        self.view?.showError(message: super.localizedString(forKey:"PAYMENT_DATA_NOT_FOUND", fromTable:stringsTableName))
    }
    
    
    /// Called when an error happens while confirming the order, it gets the error message from the strings file
    func showConfirmOrderFailedError() {
        self.view?.showError(message: super.localizedString(forKey:"CONFIRM_ORDER_FAILED", fromTable:stringsTableName))
    }
    
    /// Called from the interactor when the payment data is found
    ///
    /// - Parameter paymentData: PaymentData object
    func got(paymentData: PaymentData) {
        self.view?.set(shippingAddress: paymentData.shippingAddress!.getFullAddress(withBreakLines: true))
        self.view?.set(cardNumber: paymentData.getDisplayCardNumber()!)
        self.view?.gotPaymentData()
    }
    
    /// Sets the shipping status
    ///
    /// - Parameter shippingStatus: Boolean
    func set(shippingStatus: Bool) {
        self.view?.set(shippingStatus: shippingStatus)
    }
    
    /// Sets the order number in the view
    ///
    /// - Parameter orderNumber: String
    func set(orderNumber: String) {
        self.view?.set(orderNumber: orderNumber)
    }
    
    
    /// Called from the interactor when the posback is done correctly
    func postbackDone() {
        self.view?.postbackDone()
        self.wireFrame?.goToOrderConfirmed()
    }
}
