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

/// TransactionFailureInteractor implements TransactionFailureInteractorInputProtocol protocol, handles the interaction to show the order summary and the right button to make the checkout
class TransactionFailureInteractor: TransactionFailureInteractorInputProtocol {

    
    
    // MARK: Variables
    weak var presenter: TransactionFailureInteractorOutputProtocol?
    
    //  MARK: initializers
    
    /// Base initiliazer
    init() {}

    // MARK: TransactionFailureInteractorInputProtocol
    func requestShoppingItemsConfigurationHandler() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
    }
}
