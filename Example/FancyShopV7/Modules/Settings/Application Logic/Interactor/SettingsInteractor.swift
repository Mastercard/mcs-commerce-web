//
//  SettingsInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
/// SettingsInteractor implements SettingsInteractorInputProtocol protocol, handles the interaction to show the settings and handles the selection
class SettingsInteractor: BaseInteractor, SettingsInteractorInputProtocol {
    
    // MARK: variables
    weak var presenter: SettingsInteractorOutputProtocol?
    var APIDataManager: SettingsAPIDataManagerInputProtocol?
    var localDatamanager: SettingsLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    /// Base initializer
    override init() {}
    
    // MARK: SettingsInteractorInputProtocol
    
    /// Changes the supress shipping status flag
    func suppressShipping() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.suppressShipping = !configuration.suppressShipping
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Changes the supress 3DS status flag
    func suppress3DS() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.suppress3DS = !configuration.suppress3DS
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Changes the express checkout status, if the user is not logged in, it will go to the login module
    func enableExpressCheckoutAction() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let user:User = User.sharedInstance
        if !configuration.enableExpressCheckout &&  !user.isLoggedIn(){
            self.presenter?.userNotLoggedIn()
        } else{
            configuration.enableExpressCheckout = !configuration.enableExpressCheckout
            if configuration.enablePairingWithCheckout == true {
                configuration.enablePairingWithCheckout = configuration.enableExpressCheckout
            }
            configuration.saveConfiguration()
            self.getSavedConfig()
        }
    }
    
    /// Changes the express checkout status, if the user is not logged in, it will go to the login module
    func enablePairingWithCheckoutAction() {
        
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.enablePairingWithCheckout = !configuration.enablePairingWithCheckout
        if configuration.enablePairingWithCheckout == true {
            configuration.enablePaymentMethodCheckout = false
        }
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Changes the checkout with payment method status flag
    func togglePaymentMethodCheckoutOptionOnOff() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.enablePaymentMethodCheckout = !configuration.enablePaymentMethodCheckout
        if configuration.enablePaymentMethodCheckout == true {
            configuration.enablePairingWithCheckout = false
        }
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Returns the saved configuration for all modules
    func getSavedConfig() {
        let conf:SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setSavedData(cards: conf.cards, language: conf.language, currency: conf.currency, shippingStatus: conf.suppressShipping,suppress3DSStatus: conf.suppress3DS, expressCheckoutStatus: conf.enableExpressCheckout,webCheckoutStatus:conf.enablePairingWithCheckout, paymentMethodCheckoutStatus: conf.enablePaymentMethodCheckout)

    }
    
    func selectPaymentMethod() {
        
        if NetworkReachability.isNetworkRechable() {
            let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
            self.presenter?.initializeSDK()
            super.initSDK(isPairingOnly: false, isExpressEnable: configuration.enableExpressCheckout) { responseObject, error in
                
                DispatchQueue.main.async {
                    self.presenter?.initializeSDKComplete()
                    let status: String = responseObject?.value(forKey: "status") as! String
                    if status == Constants.status.OK {
                        
                        self.presenter?.paymentMethod()
                        
                    } else if status == Constants.status.NOK && error != nil {
                        
                        self.presenter?.showSDKInitializationError()
                    }
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
    
    func selectParingOnlyMethod() {
        
        if NetworkReachability.isNetworkRechable() {
            let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
            self.presenter?.initializeSDK()
            super.initSDK(isPairingOnly: true, isExpressEnable: configuration.enableExpressCheckout) { responseObject, error in
                
                DispatchQueue.main.async {
                    self.presenter?.initializeSDKComplete()
                    
                    //Web Paring Only
                    let status: String = responseObject?.value(forKey: "status") as! String
                    if status == Constants.status.OK {
                        //NOTE:Delay is added just to ensure activity indicator will be hidden
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            MCCMerchant.pairing(withCheckout: false, merchantDelegate: MasterpassSDKManager.sharedInstance)
                        }
                    } else if status == Constants.status.NOK && error != nil{
                        self.presenter?.showSDKInitializationError()
                    }
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
}
