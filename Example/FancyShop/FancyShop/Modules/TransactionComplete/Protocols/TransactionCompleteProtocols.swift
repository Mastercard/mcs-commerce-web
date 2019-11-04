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


/// Method contract between PRESENTER -> VIEW
protocol TransactionCompleteViewProtocol: class {
    var presenter: TransactionCompletePresenterProtocol? { get set }
    func showItemsInCart(items: [ShoppingCartItem])
    func showError(message: String)
    func set(taxes: String)
    func set(subtotal: String)
    func set(total: String)
    func set(shippingAddress: String)
    func set(cardNumber: String)
    func set(orderNumber: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol TransactionCompleteWireFrameProtocol: class {
    static func presentTransactionCompleteModule(fromView view: AnyObject)
    func goBackToProductList(animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol TransactionCompletePresenterProtocol: class {
    var view: TransactionCompleteViewProtocol? { get set }
    var interactor: TransactionCompleteInteractorInputProtocol? { get set }
    var wireFrame: TransactionCompleteWireFrameProtocol? { get set }
    
    func goBackToProductList(animated: Bool)
    func fetchItemsFromShoppingCart()
    func getPaymentData()
    func orderConfirmed()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol TransactionCompleteInteractorOutputProtocol: class {
    
    func itemsFetched(items: [ShoppingCartItem])
    func goBackToShoppingCart()
    
    func set(taxes: Double)
    func set(subtotal: Double)
    func set(total: Double)
    func set(shippingAddress: String)
    func show(error: String)
    func got(paymentData: PaymentData)
    func set(orderNumber: String)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol TransactionCompleteInteractorInputProtocol: class
{
    var presenter: TransactionCompleteInteractorOutputProtocol? { get set }
    var APIDataManager: TransactionCompleteAPIDataManagerInputProtocol? { get set }
    var localDatamanager: TransactionCompleteLocalDataManagerInputProtocol? { get set }
    
    func getItemsOnShoppingCart()
    func getPaymentData()
    func orderConfirmed()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol TransactionCompleteDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol TransactionCompleteAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol TransactionCompleteLocalDataManagerInputProtocol: class{
}
