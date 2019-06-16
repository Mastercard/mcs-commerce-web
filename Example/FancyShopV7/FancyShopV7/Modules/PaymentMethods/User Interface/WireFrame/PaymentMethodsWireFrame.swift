//
//  PaymentMethodsWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
/// Wireframe that handles all routing between views
class PaymentMethodsWireFrame: PaymentMethodsWireFrameProtocol {
    
    // MARK: OrderSummaryWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentPaymentMethodsModule(fromView: AnyObject,finalCallback: (() -> Void)?) {
        
        // Generating module components
        let view: PaymentMethodsViewProtocol = PaymentMethodsViewController.instantiate()
        let presenter: PaymentMethodsPresenterProtocol & PaymentMethodsInteractorOutputProtocol = PaymentMethodsPresenter()
        let interactor: PaymentMethodsInteractorInputProtocol = PaymentMethodsInteractor()
        let APIDataManager: PaymentMethodsAPIDataManagerInputProtocol = PaymentMethodsAPIDataManager()
        let localDataManager: PaymentMethodsLocalDataManagerInputProtocol = PaymentMethodsLocalDataManager()
        let wireFrame: PaymentMethodsWireFrameProtocol = PaymentMethodsWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! PaymentMethodsViewController
        viewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        viewController.finalCallback = finalCallback
        NavigationHelper.presentViewController(viewController: viewController)
    }
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    /// Goes to login module
    func goToLogin() {
        LoginWireFrame.presentLoginModule(isEnablingExpressCheckout: false)
    }
    
}
