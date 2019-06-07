//
//  AllowedDSRPListWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Wireframe that handles all routing between views
class AllowedDSRPListWireFrame: AllowedDSRPListWireFrameProtocol {
    
    // MARK: AllowedDSRPListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentAllowedDSRPListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: AllowedDSRPListViewProtocol = AllowedDSRPListViewController.instantiate()
        let presenter: AllowedDSRPListPresenterProtocol & AllowedDSRPListInteractorOutputProtocol = AllowedDSRPListPresenter()
        let interactor: AllowedDSRPListInteractorInputProtocol = AllowedDSRPListInteractor()
        let APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol = AllowedDSRPListAPIDataManager()
        let localDataManager: AllowedDSRPListLocalDataManagerInputProtocol = AllowedDSRPListLocalDataManager()
        let wireFrame: AllowedDSRPListWireFrameProtocol = AllowedDSRPListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! AllowedDSRPListViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    
    /// Goes back to the previous view
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
