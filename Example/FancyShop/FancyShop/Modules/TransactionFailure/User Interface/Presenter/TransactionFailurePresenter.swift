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
class TransactionFailurePresenter: TransactionFailurePresenterProtocol, TransactionFailureInteractorOutputProtocol {
 
    // MARK: Varaiables
    weak var view: TransactionFailureViewProtocol?
    var interactor: TransactionFailureInteractorInputProtocol?
    var wireFrame: TransactionFailureWireFrameProtocol?
    
    // MARK: Initializers
    
    /// Base initializer
    init() {}

    // MARK: TransactionFailurePresenterProtocol
    
    /// Goes to order summery module
    func goBackToOrderSummery(animated: Bool) {
        self.wireFrame?.goBackToOrderSummery(animated: animated)
    }
    
    /// Request the shopping cart information to the interactor
    func requestShoppingItemsConfigurationHandler() {
        self.interactor?.requestShoppingItemsConfigurationHandler()
    }
    
    // MARK: TransactionFailureInteractorOutputProtocol
    
    /// Tells the view to show the number of products in the cart
    ///
    /// - Parameter quantity: number of products in the cart
    func showQuantityOfProducts(quantity: Int) {
        self.view?.showQuantityOfProductsInCartButton(quantity: quantity)
    }
}

