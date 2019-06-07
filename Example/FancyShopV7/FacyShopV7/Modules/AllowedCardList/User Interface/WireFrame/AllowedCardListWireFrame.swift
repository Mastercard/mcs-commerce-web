//
//  AllowedCardListWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Wireframe that handles all routing between views
class AllowedCardListWireFrame: AllowedCardListWireFrameProtocol {
    
    // MARK: AllowedCardListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentAllowedCardListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: AllowedCardListViewProtocol = AllowedCardListViewController.instantiate()
        let presenter: AllowedCardListPresenterProtocol & AllowedCardListInteractorOutputProtocol = AllowedCardListPresenter()
        let interactor: AllowedCardListInteractorInputProtocol = AllowedCardListInteractor()
        let APIDataManager: AllowedCardListAPIDataManagerInputProtocol = AllowedCardListAPIDataManager()
        let localDataManager: AllowedCardListLocalDataManagerInputProtocol = AllowedCardListLocalDataManager()
        let wireFrame: AllowedCardListWireFrameProtocol = AllowedCardListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! AllowedCardListViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    
    /// Goes back to the previous view
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
