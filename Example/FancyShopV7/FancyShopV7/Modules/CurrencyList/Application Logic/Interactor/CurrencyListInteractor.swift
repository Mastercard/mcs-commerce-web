//
//  CurrencyListInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Handles selected currency logic, implements CurrencyListInteractorInputProtocol protocol, responsable of save and retrieve the used currency
class CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    
    // MARK: Variables
    
    /// CurrencyListInteractorOutputProtocol optional instance
    weak var presenter: CurrencyListInteractorOutputProtocol?
    
    /// CurrencyListAPIDataManagerInputProtocol optional instance
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol?
    
    /// CurrencyListLocalDataManagerInputProtocol optional instance
    var localDatamanager: CurrencyListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    // MARK: CurrencyListInteractorInputProtocol
    
    /// Gets the currency from the configuration and pass it to the presenter
    func getCurrentCurrency() {
        let config: SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setCurrent(currency: config.currency)
    }
    
    /// Saves the new currency in the configuration
    ///
    /// - Parameter currency: String
    func currencySelected(currency: String) {
        SDKConfiguration.sharedInstance.setCurrency(currency: currency)
    }
}
