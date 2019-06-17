//
//  TransactionCompleteWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class TransactionCompleteWireFrame: TransactionCompleteWireFrameProtocol {
    
    // MARK: TransactionCompleteWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentTransactionCompleteModule(fromView: AnyObject) {
        
        // Generating module components
        let view: TransactionCompleteViewProtocol = TransactionCompleteViewController.instantiate() as! TransactionCompleteViewProtocol
        let presenter: TransactionCompletePresenterProtocol & TransactionCompleteInteractorOutputProtocol = TransactionCompletePresenter()
        let interactor: TransactionCompleteInteractorInputProtocol = TransactionCompleteInteractor()
        let APIDataManager: TransactionCompleteAPIDataManagerInputProtocol = TransactionCompleteAPIDataManager()
        let localDataManager: TransactionCompleteLocalDataManagerInputProtocol = TransactionCompleteLocalDataManager()
        let wireFrame: TransactionCompleteWireFrameProtocol = TransactionCompleteWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! TransactionCompleteViewController
        NavigationHelper.pushViewController(viewController: viewController)
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.popToRootViewController(animated: animated)
    }
}
