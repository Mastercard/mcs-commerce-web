//
//  LanguageListWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class LanguageListWireFrame: LanguageListWireFrameProtocol {
    
    // MARK: LanguageListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentLanguageListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: LanguageListViewProtocol = LanguageListViewController.instantiate() as! LanguageListViewProtocol
        let presenter: LanguageListPresenterProtocol & LanguageListInteractorOutputProtocol = LanguageListPresenter()
        let interactor: LanguageListInteractorInputProtocol = LanguageListInteractor()
        let APIDataManager: LanguageListAPIDataManagerInputProtocol = LanguageListAPIDataManager()
        let localDataManager: LanguageListLocalDataManagerInputProtocol = LanguageListLocalDataManager()
        let wireFrame: LanguageListWireFrameProtocol = LanguageListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! LanguageListViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
