//
//  SettingsProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation


/// Method contract between PRESENTER -> VIEW
protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol? { get set }
    
    func setSavedData(cards: [CardConfiguration], language: String, currency: String, shippingStatus: Bool,suppress3DSStatus: Bool, expressCheckoutStatus: Bool,webCheckoutStatus: Bool, paymentMethodCheckoutStatus: Bool)
    func startAnimating()
    func stopAnimating()
    func showError(error: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol SettingsWireFrameProtocol: class {
    static func presentSettingsModule(fromView view: AnyObject)
    
    func goBackToProductList(animated: Bool)
    func goToLanguageList()
    func gotToAllowedCardList()
    func gotToCurrencyList()
    func gotToAllowedDSRPList()
    func goToLogin()
    func goToPaymentMethods(completion: (() -> Void)?)
}

/// Method contract between VIEW -> PRESENTER
protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var wireFrame: SettingsWireFrameProtocol? { get set }
    func goBackToProductList(animated: Bool)
    func goToLanguageList()
    func gotToAllowedCardList()
    func gotToCurrencyList()
    func suppressShippingAction()
    func suppress3DSAction()
    func enableExpressCheckoutAction()
    func enablePairingWithCheckoutAction()
    func togglePaymentMethodCheckoutOptionOnOff()
    func gotToAllowedDSRPList()
    func getSavedConfig()
    func selectPaymentMethod()
    func selectParingOnlyMethod()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol SettingsInteractorOutputProtocol: class {
    func setSavedData(cards: [CardConfiguration], language: String, currency: String, shippingStatus: Bool,suppress3DSStatus: Bool, expressCheckoutStatus: Bool,webCheckoutStatus: Bool, paymentMethodCheckoutStatus: Bool)
    func userNotLoggedIn()
    func initializeSDK()
    func initializeSDKComplete()
    func selectPaymentMethod()
    func selectParingOnlyMethod()
    func showSDKInitializationError()
    func paymentMethod()
    func showNetworkError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol SettingsInteractorInputProtocol: class
{
    var presenter: SettingsInteractorOutputProtocol? { get set }
    var APIDataManager: SettingsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: SettingsLocalDataManagerInputProtocol? { get set }
    func suppressShipping()
    func suppress3DS()
    func enableExpressCheckoutAction()
    func enablePairingWithCheckoutAction()
    func togglePaymentMethodCheckoutOptionOnOff()
    func getSavedConfig()
    func selectPaymentMethod()
    func selectParingOnlyMethod()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol SettingsDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol SettingsAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol SettingsLocalDataManagerInputProtocol: class{
}
