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
        let paymentdata : PaymentData = PaymentData.sharedInstance
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.callShoppingTotalizers()
        self.presenter?.set(orderNumber: shoppingCart.cartId)
        self.presenter?.set(shippingAddress:(paymentdata.shippingAddress?.getFullAddress(withBreakLines:false))! )
    }
    
    /// Passes the payment data
    func getPaymentData() {
        self.presenter?.got(paymentData: PaymentData.sharedInstance)
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
        ShoppingCart.saveShoppingCart()
    }
}
