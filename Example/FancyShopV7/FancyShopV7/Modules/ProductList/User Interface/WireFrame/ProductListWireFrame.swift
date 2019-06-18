//
//  ProductListWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
/// Wireframe that handles all routing between views
class ProductListWireFrame: ProductListWireFrameProtocol {
    // MARK: ProductListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentProductListModule(fromView: AnyObject){
        
        // Generating module components
        let view: ProductListViewProtocol = ProductListViewController.instantiate()
        let presenter: ProductListPresenterProtocol & ProductListInteractorOutputProtocol = ProductListPresenter()
        let interactor: ProductListInteractorInputProtocol = ProductListInteractor()
        let APIDataManager: ProductListAPIDataManagerInputProtocol = ProductListAPIDataManager()
        let localDataManager: ProductListLocalDataManagerInputProtocol = ProductListLocalDataManager()
        let wireFrame: ProductListWireFrameProtocol = ProductListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        
        //Since is the first view controller, we need to set the navigation controller too
        let viewController = view as! ProductListViewController
        NavigationHelper.setRootViewController(withViewController: viewController);
    }
    
    /// Goes to settings module
    func presentSettingsModule() {
        SettingsWireFrame.presentSettingsModule(fromView: self)
    }
    
    /// Goes to confirm order module
    func presentConfirmOrderModule() {
        OrderSummaryWireFrame.presentOrderSummaryModule(fromView: self)
    }
    
    /// Goes to login module
    func goToLogin() {
        LoginWireFrame.presentLoginModule(isEnablingExpressCheckout: false)
    }
}
