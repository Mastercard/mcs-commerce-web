//
//  CurrencyListWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class CurrencyListWireFrame: CurrencyListWireFrameProtocol {
    
    // MARK: CurrencyListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentCurrencyListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: CurrencyListViewProtocol = CurrencyListViewController.instantiate() as! CurrencyListViewProtocol
        let presenter: CurrencyListPresenterProtocol & CurrencyListInteractorOutputProtocol = CurrencyListPresenter()
        let interactor: CurrencyListInteractorInputProtocol = CurrencyListInteractor()
        let APIDataManager: CurrencyListAPIDataManagerInputProtocol = CurrencyListAPIDataManager()
        let localDataManager: CurrencyListLocalDataManagerInputProtocol = CurrencyListLocalDataManager()
        let wireFrame: CurrencyListWireFrameProtocol = CurrencyListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! CurrencyListViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
