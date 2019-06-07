//
//  CurrencyListPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class CurrencyListPresenter: CurrencyListPresenterProtocol, CurrencyListInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var wireFrame: CurrencyListWireFrameProtocol?
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    //MARK: CurrencyListPresenterProtocol
    
    /// Ask for the current currency
    func getCurrentCurrency() {
        self.interactor?.getCurrentCurrency()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        self.wireFrame?.goBack(animated)
    }
    
    /// Tells the interactor that a currency has been selected
    ///
    /// - Parameter currency: String with the currency
    func currencySelected(currency: String) {
        self.interactor?.currencySelected(currency: currency)
    }
    
    //MARK: CurrencyListInteractorOutputProtocol
    
    /// Tells the view to show the current curency
    ///
    /// - Parameter currency: String with the currency
    func setCurrent(currency: String) {
        self.view?.setCurrent(currency: currency)
    }
}
