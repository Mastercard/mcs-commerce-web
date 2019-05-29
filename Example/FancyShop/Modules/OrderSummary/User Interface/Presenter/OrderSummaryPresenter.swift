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
class OrderSummaryPresenter:BasePresenter, OrderSummaryPresenterProtocol, OrderSummaryInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: OrderSummaryViewProtocol?
    var interactor: OrderSummaryInteractorInputProtocol?
    var wireFrame: OrderSummaryWireFrameProtocol?
    // MARK: Constants
    let stringsTableName = "OrderSummary"
    
    // MARK: OrderSummaryPresenterProtocol
    
    /// Request the shopping cart information to the interactor
    func requestShoppingCartViewConfiguration() {
        self.interactor?.requestShoppingCartViewConfigurationHandler()
    }
    
    /// Request the shopping cart items from the cart
    func fetchItemsFromShoppingCart() {
        self.interactor?.getItemsOnShoppingCart()
    }
    
    /// Request to remove one product from the item
    ///
    /// - Parameter product: Product to remove
    func lessProductQuantityAction(product: Product) {
        self.interactor?.lessProductQuantity(product: product)
    }
    
    /// Request to add one product to the item
    ///
    /// - Parameter product: Product to add
    func moreProductQuantityAction(product: Product) {
        self.interactor?.moreProductQuantity(product: product)
    }
    
    /// Request to remove one product from the item
    ///
    /// - Parameter product: Product to remove
    func removeProductAction(product: Product) {
        self.interactor?.removeProductFromShoppingCart(product: product)
    }
    
    /// Ask the interactor to evaluates which flow has to be done for the checkout
    func getCheckoutButton() {
        self.interactor?.getCheckoutFlow()
    }
    
    /// Payment methods selection request
    func paymentMethodSelectionButtonAction() {
        self.wireFrame?.goToPaymentMethods(completion: {
            self.view?.showPaymentMethodCheckoutButton()
        })
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBackToProductList(animated: Bool) {
        self.wireFrame?.goBackToProductList(animated: animated)
    }
    
    /// request to perforn checkout
    func performCheckout(completionHandler: @escaping ([AnyHashable : Any]?, Error?) -> ()) {
        self.interactor?.performCheckout(completionHandler: { (response, error) in
            if((error) != nil) {
                completionHandler(response,error)
            } else {
                self.goToConfirmOrderWithPaymentData(paymentData: response as AnyObject)
            }
        })
    }
    
    
    // MARK: OrderSummaryInteractorOutputProtocol
    
    /// Tells the view to show the number of products in the cart
    ///
    /// - Parameter quantity: number of products in the cart
    func showQuantityOfProducts(quantity: Int) {
        self.view?.showQuantityOfProductsInCartButton(quantity: quantity)
    }
    
    /// Tells the view the items in the cart
    ///
    /// - Parameter items: ShoppingCartItem array
    func itemsFetched(items: [ShoppingCartItem]) {
        self.view?.showItemsInCart(items: items)
    }
    
    /// Goes back to the previous screen, called from the interactor
    func goBackToProductList() {
        self.wireFrame?.goBackToProductList(animated: true)
    }
    
    /// Goes to confirmOrder Screen, with storepayment data response
    func goToConfirmOrderWithPaymentData(paymentData:AnyObject){
        self.wireFrame?.goToConfirmOrderWithPaymentData(paymentData: paymentData)
    }
    
    /// Set the taxes
    ///
    /// - Parameter taxes: Taxes value
    func set(taxes: Double) {
        self.view?.set(taxes: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", taxes))
    }
    /// Set the subtotal
    ///
    /// - Parameter taxes: Taxes subtotal
    func set(subtotal: Double) {
        self.view?.set(subtotal: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", subtotal))
    }
    /// Set the total
    ///
    /// - Parameter taxes: total value
    func set(total: Double) {
        self.view?.set(total: SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", total))
    }
    
    /// Shows an error if the SDK has issues to initialize
    func showSDKInitializationError() {
        self.view?.showError(error:super.localizedString(forKey: "SDK_INITIALIZATION_ERROR", fromTable: stringsTableName))
    }
    /// Set the shippingStatus
    ///
    /// - Parameter taxes: shippingStatus value, used to hide or show the shipping address view
    func set(shippingStatus: Bool) {
        self.view?.set(shippingStatus: shippingStatus)
    }
    
    /// If PaymentMethod checkout is disable, this method is called
    func showMasterpassButtonCheckoutFlow(){
        self.view?.showMCCButton()
    }
    
    /// If paymentMethod checkout is enabled, this method is called
    func showPaymentMethodCheckoutFlow() {
        self.view?.showPaymentMethodCheckoutButton()
    }
        
    /// Animates the view when SDK Initialization start
    func startActivityLoader() {
        self.view?.startAnimating()
    }
    
    /// Animates the view when SDK Initialization Complete
    func stopActivityLoader() {
        self.view?.stopAnimating()
    }
    
    /// Shows an alert to add payment method, if not added.
    func showAddPaymentMethodAlert() {
        self.view?.showAddPaymentMethodAlert(alertMsg: super.localizedString(forKey: "PAYMENT_METHOD_NOT_ADDED", fromTable: stringsTableName))
    }
}