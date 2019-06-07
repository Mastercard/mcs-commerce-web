//
//  ConfirmOrderProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb


/// Method contract between PRESENTER -> VIEW
protocol ConfirmOrderViewProtocol: class {
    var presenter: ConfirmOrderPresenterProtocol? { get set }
    
    func showItemsInCart(items: [ShoppingCartItem])
    func showError(message: String)
    func set(taxes: String)
    func set(subtotal: String)
    func set(total: String)
    func set(shippingAddress: String)
    func set(cardNumber: String)
    func set(cardBrandImage: String)
    func set(cardName: String)
    func gotPaymentData()
    func set(shippingStatus: Bool)
    func set(orderNumber: String)
    func postbackDone()
}

/// Method contract between PRESENTER -> WIREFRAME
protocol ConfirmOrderWireFrameProtocol: class {
    static func presentConfirmOrderModule(fromView: AnyObject,paymentData: PaymentData?)
    
    func goBackToProductList(animated: Bool)
    func goToOrderConfirmed()
}

/// Method contract between VIEW -> PRESENTER
protocol ConfirmOrderPresenterProtocol: class {
    var view: ConfirmOrderViewProtocol? { get set }
    var interactor: ConfirmOrderInteractorInputProtocol? { get set }
    var wireFrame: ConfirmOrderWireFrameProtocol? { get set }
    
    func goBackToProductList(animated: Bool)
    func fetchItemsFromShoppingCart()
    func getPaymentData()
    func confirmOrderAction()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol ConfirmOrderInteractorOutputProtocol: class {
    func itemsFetched(items: [ShoppingCartItem])
    func goBackToShoppingCart()
    
    func set(taxes: Double)
    func set(subtotal: Double)
    func set(total: Double)
    func showPaymentDataNotFoundError()
    func got(paymentData: PaymentData)
    func set(shippingStatus: Bool)
    func set(orderNumber: String)
    func postbackDone()
    func showConfirmOrderFailedError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol ConfirmOrderInteractorInputProtocol: class
{
    var presenter: ConfirmOrderInteractorOutputProtocol? { get set }
    var APIDataManager: ConfirmOrderAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ConfirmOrderLocalDataManagerInputProtocol? { get set }
    
    func getItemsOnShoppingCart()
    func getPaymentData()
    func confirmOrder()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol ConfirmOrderDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol ConfirmOrderAPIDataManagerInputProtocol: class{
    func getPaymentData(completionHandler: @escaping (NSDictionary?, Error?) -> ())
    func confirmOrder(completionHandler: @escaping (NSDictionary?, Error?) -> ())
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol ConfirmOrderLocalDataManagerInputProtocol: class{
}
