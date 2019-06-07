//
//  SettingsPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class SettingsPresenter: BasePresenter, SettingsPresenterProtocol, SettingsInteractorOutputProtocol {
    
    let stringsTableName = "Settings"
    // MARK: variables
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var wireFrame: SettingsWireFrameProtocol?
    
    // MARK: Initializers
    
    /// Base initializer
    override init() {}
    
    // MARK: SettingsPresenterProtocol
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBackToProductList(animated: Bool) {
        self.wireFrame?.goBackToProductList(animated: animated)
    }
    
    /// Goes to language module
    func goToLanguageList() {
        self.wireFrame?.goToLanguageList()
    }
    
    /// Goes to Allowed card list module
    func gotToAllowedCardList() {
        self.wireFrame?.gotToAllowedCardList()
    }
    
    /// Goes to Currency list module
    func gotToCurrencyList() {
        self.wireFrame?.gotToCurrencyList()
    }
    
    /// Changes the suppress shipping flag status
    func suppressShippingAction() {
        self.interactor?.suppressShipping()
    }
    
    /// Changes the suppress 3DS flag status
    func suppress3DSAction() {
       self.interactor?.suppress3DS()
    }
    
    /// Changes the express checkout flag status
    func enableExpressCheckoutAction() {
        self.interactor?.enableExpressCheckoutAction()
    }
    
    /// Changes the web express checkout  
    func enablePairingWithCheckoutAction() {
        self.interactor?.enablePairingWithCheckoutAction()
    }
    
    /// Changes the checkout with payment method flag status
    func togglePaymentMethodCheckoutOptionOnOff() {
        self.interactor?.togglePaymentMethodCheckoutOptionOnOff()
    }
    
    ///select payment method flag status
    func selectPaymentMethod() {
        self.interactor?.selectPaymentMethod()
    }
    
    ///Do Paring Only
    func selectParingOnlyMethod() {
        self.interactor?.selectParingOnlyMethod()
    }
    
    func paymentMethod() {
        
        self.wireFrame?.goToPaymentMethods(completion: {
            
        })
    }
    
    /// Goes to Allowed DSRP module
    func gotToAllowedDSRPList() {
        self.wireFrame?.gotToAllowedDSRPList()
    }
    
    /// Ask for the saved configuration
    func getSavedConfig() {
        self.interactor?.getSavedConfig()
    }
    
    // MARK: SettingsInteractorOutputProtocol
    
    /// Passes the saved configuration to the view
    ///
    /// - Parameters:
    ///   - cards: Cards array
    ///   - language: selected language
    ///   - currency: selected currency
    ///   - shippingStatus: shipping status flag
    ///   - expressCheckoutStatus: express checkout flag
    ///   - paymentMethodStatus: payment Method enable flag
    func setSavedData(cards: [CardConfiguration], language: String, currency: String, shippingStatus: Bool,suppress3DSStatus:Bool, expressCheckoutStatus: Bool, webCheckoutStatus:Bool, paymentMethodCheckoutStatus: Bool) {
        self.view?.setSavedData(cards: cards, language: language, currency: currency, shippingStatus: shippingStatus,suppress3DSStatus:suppress3DSStatus, expressCheckoutStatus: expressCheckoutStatus, webCheckoutStatus: webCheckoutStatus, paymentMethodCheckoutStatus: paymentMethodCheckoutStatus)
    }
    
    /// Goes to login module
    func userNotLoggedIn() {
        self.wireFrame?.goToLogin()
    }
    
    /// Animates the view when SDK Initialization start
    func initializeSDK() {
        self.view?.startAnimating()
    }
    
    /// Animates the view when SDK Initialization Complete
    func initializeSDKComplete() {
        self.view?.stopAnimating()
    }
    
    /// Shows an error if the SDK has issues to initialize
    func showSDKInitializationError() {
        self.view?.showError(error:super.localizedString(forKey: "SDK_INITIALIZATION_ERROR", fromTable: stringsTableName))
    }
    
    /// Shows an error if network is not available
    func showNetworkError() {
        self.view?.showError(error:super.localizedString(forKey: "INTERNET_ERROR", fromTable: stringsTableName))
    }
}
