//
//  OrderSummaryProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

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
    func set(shippingStatus: Bool)
    func showExpressCheckoutButton()
    func showPaymentMethodCheckoutButton()
    func startAnimating()
    func stopAnimating()
}


/// Method contract between PRESENTER -> WIREFRAME
protocol OrderSummaryWireFrameProtocol: class {
    static func presentOrderSummaryModule(fromView view: AnyObject)
    
    func goBackToProductList(animated: Bool)
    func gotToPreCheckoutData()
    func goToPaymentMethods(completion: (() -> Void)?)
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
    func getCheckoutButton()
    func expressCheckoutButtonAction()
    func paymentMethodSelectionButtonAction()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol OrderSummaryInteractorOutputProtocol: class {
    
    func showQuantityOfProducts(quantity: Int)
    func itemsFetched(items: [ShoppingCartItem])
    func goBackToProductList()
    
    func set(taxes: Double)
    func set(subtotal: Double)
    func set(total: Double)
    func showSDKInitializationError()
    func showMasterpassButtonCheckoutFlow()
    func set(shippingStatus: Bool)
    func showExpressCheckoutFlow()
    func showPaymentMethodCheckoutFlow()
    func showPairingIdError()
    func gettingPairingId()
    func gottenPairingId()
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
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol OrderSummaryDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol OrderSummaryAPIDataManagerInputProtocol: class{
    func getPairingId(completionHandler: @escaping (NSDictionary?, Error?) -> ())
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol OrderSummaryLocalDataManagerInputProtocol: class{
}
