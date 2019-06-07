//
//  ConfirmOrderWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Wireframe that handles all routing between views
class ConfirmOrderWireFrame: ConfirmOrderWireFrameProtocol {
    
    // MARK: AllowedCardListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentConfirmOrderModule(fromView: AnyObject, paymentData: PaymentData?) {
        
        // Generating module components
        let view: ConfirmOrderViewProtocol = ConfirmOrderViewController.instantiate() as! ConfirmOrderViewProtocol
        let presenter: ConfirmOrderPresenterProtocol & ConfirmOrderInteractorOutputProtocol = ConfirmOrderPresenter()
        let interactor: ConfirmOrderInteractorInputProtocol = ConfirmOrderInteractor(withPaymentData: paymentData)
        let APIDataManager: ConfirmOrderAPIDataManagerInputProtocol = ConfirmOrderAPIDataManager()
        let localDataManager: ConfirmOrderLocalDataManagerInputProtocol = ConfirmOrderLocalDataManager()
        let wireFrame: ConfirmOrderWireFrameProtocol = ConfirmOrderWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! ConfirmOrderViewController
        NavigationHelper.pushViewController(viewController: viewController)
    }
    /// Goes back to the previous view
    ///
    /// - Parameter animated: animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.popToRootViewController(animated: animated)
    }
    
    /// Goes back to Order confirmed module
    func goToOrderConfirmed() {
        TransactionCompleteWireFrame.presentTransactionCompleteModule(fromView: self)
    }
}
