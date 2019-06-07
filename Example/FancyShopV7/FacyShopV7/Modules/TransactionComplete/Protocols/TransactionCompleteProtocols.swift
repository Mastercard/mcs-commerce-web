//
//  TransactionCompleteProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb

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
    func set(shippingStatus: Bool)
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
    func show(error: String)
    func got(paymentData: PaymentData)
    func set(shippingStatus: Bool)
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
