//
//  SettingsWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class SettingsWireFrame: SettingsWireFrameProtocol {
    
    // MARK: SettingsWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentSettingsModule(fromView: AnyObject) {
        
        // Generating module components
        let view: SettingsViewProtocol = SettingsViewController.instantiate()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        let APIDataManager: SettingsAPIDataManagerInputProtocol = SettingsAPIDataManager()
        let localDataManager: SettingsLocalDataManagerInputProtocol = SettingsLocalDataManager()
        let wireFrame: SettingsWireFrameProtocol = SettingsWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        
        let viewController = view as! SettingsViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to language list module
    func goToLanguageList() {
        LanguageListWireFrame.presentLanguageListModule(fromView: self)
    }
    /// Goes to Allowed Card List module
    func gotToAllowedCardList() {
        AllowedCardListWireFrame.presentAllowedCardListModule(fromView: self)
    }
    /// Goes to Currency List module
    func gotToCurrencyList() {
        CurrencyListWireFrame.presentCurrencyListModule(fromView: self)
    }
    /// Goes to Allowed DSRP module
    func gotToAllowedDSRPList() {
        AllowedDSRPListWireFrame.presentAllowedDSRPListModule(fromView: self)
    }
    
    /// Goes to login module
    func goToLogin() {
        LoginWireFrame.presentLoginModule(isEnablingExpressCheckout:true)
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods(completion: (() -> Void)?) {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: completion)
    }
}
