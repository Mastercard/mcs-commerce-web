//
//  LoginWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class LoginWireFrame: LoginWireFrameProtocol {

    // MARK: LoginWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentLoginModule(isEnablingExpressCheckout: Bool) {
        
        // Generating module components
        let view: LoginViewProtocol = LoginViewController.instantiate()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor(isEnablingExpressCheckout: isEnablingExpressCheckout)
        let APIDataManager: LoginAPIDataManagerInputProtocol = LoginAPIDataManager()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! LoginViewController
        NavigationHelper.pushViewController(viewController: viewController)
    }
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods(completion: (() -> Void)?) {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: completion)
    }
}
