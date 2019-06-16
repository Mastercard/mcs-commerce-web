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
import MCSCommerceWeb

/// OrderSummaryInteractor implements OrderSummaryInteractorInputProtocol protocol, handles the interaction to show the order summary and the right button to make the checkout
class OrderSummaryInteractor:BaseInteractor, OrderSummaryInteractorInputProtocol {

    // MARK: Variables
    weak var presenter: OrderSummaryInteractorOutputProtocol?
    var APIDataManager: OrderSummaryAPIDataManagerInputProtocol?
    var localDatamanager: OrderSummaryLocalDataManagerInputProtocol?
    
    // MARK: OrderSummaryInteractorInputProtocol
    
    /// Handles the request to get the number of items on the cart
    func requestShoppingCartViewConfigurationHandler() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
    }
    
    /// Handles the request to get the items on the cart
    func getItemsOnShoppingCart() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.set(shippingStatus: SDKConfiguration.sharedInstance.suppressShipping)
        self.callShoppingTotalizers()
    }
    
    /// Removes a product from the cart, if the product number is 0, it will go back to the product list
    ///
    /// - Parameter product: Product to remove
    func lessProductQuantity(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.removeProduct(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
        
        if shoppingCart.items.count == 0 {
            self.presenter?.goBackToProductList()
        }
    }
    
    
    /// Adds a product to the cart
    ///
    /// - Parameter product: Product to add
    func moreProductQuantity(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.addProduct(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
    }
    
    /// Removes a item from the cart
    ///
    /// - Parameter product: Product to remove
    func removeProductFromShoppingCart(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.removeAllProductsFromItem(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
        
        if shoppingCart.items.count == 0 {
            self.presenter?.goBackToProductList()
        }
    }
        
    /// Evaluates the checkout flow to follow, if it has all the data and the configuration is enable, will go for a express checkout
    func getCheckoutFlow() {
        self.APIDataManager?.initializeSdk()
    }
    
    func getCheckoutButton(completionHandler: @escaping ([AnyHashable : Any]?, Error?) -> ()) -> MCSCheckoutButton {
        return (self.APIDataManager?.getCheckoutButton(completionHandler: completionHandler))!
    }
    
    func initializeSdk() {
        self.APIDataManager?.initializeSdk()
    }
    
    /// Passes the taxes, subtotal and total from the shopping cart
    fileprivate func callShoppingTotalizers() {
        let shoppingCart = ShoppingCart.sharedInstance
        self.presenter?.set(taxes: shoppingCart.taxes)
        self.presenter?.set(subtotal: shoppingCart.subtotal)
        self.presenter?.set(total: shoppingCart.total)
    }
    
    func performCheckout(completionHandler: @escaping ([AnyHashable : Any]?, Error?) -> ()) {
        self.APIDataManager?.performCheckout(completionHandler: { (response, error) in
            completionHandler(response,error)
        })
    }
    
}
