//
//  CurrencyListProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Method contract between PRESENTER -> VIEW
protocol CurrencyListViewProtocol: class {
    var presenter: CurrencyListPresenterProtocol? { get set }
    func setCurrent(currency: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol CurrencyListWireFrameProtocol: class {
    static func presentCurrencyListModule(fromView view: AnyObject)
    func goBack(_ animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol CurrencyListPresenterProtocol: class {
    var view: CurrencyListViewProtocol? { get set }
    var interactor: CurrencyListInteractorInputProtocol? { get set }
    var wireFrame: CurrencyListWireFrameProtocol? { get set }
    
    func getCurrentCurrency()
    func goBack(_ animated: Bool)
    func currencySelected(currency: String)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol CurrencyListInteractorOutputProtocol: class {
    func setCurrent(currency: String)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol CurrencyListInteractorInputProtocol: class
{
    var presenter: CurrencyListInteractorOutputProtocol? { get set }
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: CurrencyListLocalDataManagerInputProtocol? { get set }
    
    func getCurrentCurrency()
    func currencySelected(currency: String)
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol CurrencyListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol CurrencyListAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol CurrencyListLocalDataManagerInputProtocol: class{
}
