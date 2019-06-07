//
//  PreCheckoutDataWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class PreCheckoutDataWireFrame: PreCheckoutDataWireFrameProtocol {
    
    // MARK: PreCheckoutDataWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentPreCheckoutDataModule(fromView: AnyObject) {
        
        // Generating module components
        let view: PreCheckoutDataViewProtocol = PreCheckoutDataViewController.instantiate()
        let presenter: PreCheckoutDataPresenterProtocol & PreCheckoutDataInteractorOutputProtocol = PreCheckoutDataPresenter()
        let interactor: PreCheckoutDataInteractorInputProtocol = PreCheckoutDataInteractor()
        let APIDataManager: PreCheckoutDataAPIDataManagerInputProtocol = PreCheckoutDataAPIDataManager()
        let localDataManager: PreCheckoutDataLocalDataManagerInputProtocol = PreCheckoutDataLocalDataManager()
        let wireFrame: PreCheckoutDataWireFrameProtocol = PreCheckoutDataWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! PreCheckoutDataViewController
        NavigationHelper.pushViewController(viewController:viewController)
    }
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBack() {
        NavigationHelper.singleBack(animated: true)
    }
    
    /// Goes to Confirm Order Module
    ///
    /// - Parameter paymentData: Payment data object
    func goToPaymentDataModule(paymentData: PaymentData) {
        ConfirmOrderWireFrame.presentConfirmOrderModule(fromView: self, paymentData: paymentData)
    }
}
