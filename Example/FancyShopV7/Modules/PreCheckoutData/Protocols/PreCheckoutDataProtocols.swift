//
//  PreCheckoutDataProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Method contract between PRESENTER -> VIEW
protocol PreCheckoutDataViewProtocol: class {
    var presenter: PreCheckoutDataPresenterProtocol? { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func startAnimating()
    func stopAnimating()
    func showError(message: String)
    func reloadData(cards:[Card], addresses: [ShippingAddress])
}

/// Method contract between PRESENTER -> WIREFRAME
protocol PreCheckoutDataWireFrameProtocol: class {
    static func presentPreCheckoutDataModule(fromView view: AnyObject)
    func goBack()
    func goToPaymentDataModule(paymentData: PaymentData)
}

/// Method contract between VIEW -> PRESENTER
protocol PreCheckoutDataPresenterProtocol: class {
    var view: PreCheckoutDataViewProtocol? { get set }
    var interactor: PreCheckoutDataInteractorInputProtocol? { get set }
    var wireFrame: PreCheckoutDataWireFrameProtocol? { get set }
    func goBack()
    func fetchData()
    func expressCheckoutAction(card:Card, shippingAddress:ShippingAddress?,suppressShipping:Bool)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol PreCheckoutDataInteractorOutputProtocol: class {
    func present(preCheckoutData: PreCheckoutData)
    func expressCheckoutDone(paymentData: PaymentData)
    func showPreCheckoutDataError()
    func showExpressCheckoutError()
    func showNetworkError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol PreCheckoutDataInteractorInputProtocol: class
{
    var presenter: PreCheckoutDataInteractorOutputProtocol? { get set }
    var APIDataManager: PreCheckoutDataAPIDataManagerInputProtocol? { get set }
    var localDatamanager: PreCheckoutDataLocalDataManagerInputProtocol? { get set }
    func fetchPreCheckoutData()
    func expressCheckout(card:Card, shippingAddress:ShippingAddress?,suppressShipping:Bool)
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol PreCheckoutDataDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol PreCheckoutDataAPIDataManagerInputProtocol: class{
    func getPreCheckoutData(completionHandler: @escaping (NSDictionary?, Error?) -> ())
    func doExpressCheckout(preCheckoutTransactionId:String, card:Card, shippingAddress:ShippingAddress?,suppressShipping:Bool, completionHandler: @escaping (NSDictionary?, Error?) -> ())
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol PreCheckoutDataLocalDataManagerInputProtocol: class{
}
