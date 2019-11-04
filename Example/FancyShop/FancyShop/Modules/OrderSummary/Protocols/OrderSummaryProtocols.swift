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


/// Method contract between PRESENTER -> VIEW
protocol OrderSummaryViewProtocol: class {
    var presenter: OrderSummaryPresenterProtocol? { get set }
    func showQuantityOfProductsInCartButton(quantity: Int)
    func showItemsInCart(items: [ShoppingCartItem])
    func showError(error: String)
    func showAddPaymentMethodAlert(alertMsg: String)
    func set(taxes: String)
    func set(subtotal: String)
    func set(total: String)
    func showMCCButton()
    func showSRCButton()
    func set(shippingStatus: Bool)
    func showPaymentMethodCheckoutButton()
    func startAnimating()
    func stopAnimating()
}


/// Method contract between PRESENTER -> WIREFRAME
protocol OrderSummaryWireFrameProtocol: class {
    static func presentOrderSummaryModule(fromView view: AnyObject)
    
    func goBackToProductList(animated: Bool)
    func goToPaymentMethods(completion: (() -> Void)?)
    func goToConfirmOrderWithPaymentData(paymentData : AnyObject)
}

/// Method contract between VIEW -> PRESENTER
protocol OrderSummaryPresenterProtocol: class {
    var view: OrderSummaryViewProtocol? { get set }
    var interactor: OrderSummaryInteractorInputProtocol? { get set }
    var wireFrame: OrderSummaryWireFrameProtocol? { get set }
    
    func goBackToProductList(animated: Bool)
    func requestShoppingCartViewConfiguration()
    func fetchItemsFromShoppingCart()
    func lessProductQuantityAction(product: Product)
    func moreProductQuantityAction(product: Product)
    func removeProductAction(product: Product)
    func expressCheckoutButtonAction()
    func paymentMethodSelectionButtonAction()
    
    func initializeSdk()
    func getCheckoutButton()
    func getSRCCheckoutButton(completionHandler: @escaping ([AnyHashable : Any]?,Error?) -> ()) -> MCSCheckoutButton
}

/// Method contract between INTERACTOR -> PRESENTER
protocol OrderSummaryInteractorOutputProtocol: class {
    
    func showQuantityOfProducts(quantity: Int)
    func itemsFetched(items: [ShoppingCartItem])
    func goBackToProductList()
    func goToConfirmOrderWithPaymentData(paymentData:AnyObject)
    func set(taxes: Double)
    func set(subtotal: Double)
    func set(total: Double)
    func showSDKInitializationError()
    func showMasterpassButtonCheckoutFlow()
    func set(shippingStatus: Bool)
    func showPaymentMethodCheckoutFlow()
    func getCheckoutButton()
    func showSRCCheckoutButton()
    func startActivityLoader()
    func stopActivityLoader()
    func initializeSDK()
    func initializeSDKComplete()
    func showAddPaymentMethodAlert()
    func showNetworkError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol OrderSummaryInteractorInputProtocol: class
{
    var presenter: OrderSummaryInteractorOutputProtocol? { get set }
    var APIDataManager: OrderSummaryAPIDataManagerInputProtocol? { get set }
    var localDatamanager: OrderSummaryLocalDataManagerInputProtocol? { get set }
    
    func requestShoppingCartViewConfigurationHandler()
    func getItemsOnShoppingCart()
    func lessProductQuantity(product: Product)
    func moreProductQuantity(product: Product)
    func removeProductFromShoppingCart(product: Product)
    func getCheckoutFlow()
    func expressCheckout()
    func initializeSdk()
    func getSRCCheckoutButton(completionHandler: @escaping ([AnyHashable : Any]?,Error?) -> ()) -> MCSCheckoutButton
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol OrderSummaryDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol OrderSummaryAPIDataManagerInputProtocol: class{
    func initializeSdk()
    func getCheckoutButton(completionHandler: @escaping ([AnyHashable : Any]?,Error?) -> ()) -> MCSCheckoutButton
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol OrderSummaryLocalDataManagerInputProtocol: class{
}
