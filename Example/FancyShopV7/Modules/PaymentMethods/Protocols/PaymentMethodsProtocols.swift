//
//  PaymentMethodsProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb


/// Method contract between PRESENTER -> VIEW
protocol PaymentMethodsViewProtocol: class {
    var presenter: PaymentMethodsPresenterProtocol? { get set }
    func setPaymentMethods(paymentMethods: [NSDictionary])
    func setAddedPaymentMethod(paymentMethod: PaymentMethod)
    func showError(error: String)
    func setUser(hasPairingId: Bool)
    func setUser(hasTransactionPairingId: Bool)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol PaymentMethodsWireFrameProtocol: class {
    static func presentPaymentMethodsModule(fromView view: AnyObject,finalCallback: (() -> Void)?)
    func goBack(animated: Bool)
    func goToLogin()
}

/// Method contract between VIEW -> PRESENTER
protocol PaymentMethodsPresenterProtocol: class {
    var view: PaymentMethodsViewProtocol? { get set }
    var interactor: PaymentMethodsInteractorInputProtocol? { get set }
    var wireFrame: PaymentMethodsWireFrameProtocol? { get set }
    func fetchPaymentMethods()
    func goBack(animated: Bool)
    func paymentMethodSelected(method: String)
    func checkIfPairingShouldBeShown()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol PaymentMethodsInteractorOutputProtocol: class {
    func setPaymentMethods(paymentMethods: [NSDictionary])
    func setAddedPaymentMethod(paymentMethod: PaymentMethod)
    func goBack(animated: Bool)
    func setUser(hasPairingId: Bool)
    func setUser(hasTransactionPairingId: Bool)
    func userIsNotLoggedIn()
    func showSDKInitializationError()
    func showSDKAddPaymentMethodError(error: Error)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol PaymentMethodsInteractorInputProtocol: class
{
    var presenter: PaymentMethodsInteractorOutputProtocol? { get set }
    var APIDataManager: PaymentMethodsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: PaymentMethodsLocalDataManagerInputProtocol? { get set }
    
    func fetchPaymentMethods()
    func paymentMethodSelected(method: String)
    func checkIfJustLoggedIn()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol PaymentMethodsDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol PaymentMethodsAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol PaymentMethodsLocalDataManagerInputProtocol: class{
}
