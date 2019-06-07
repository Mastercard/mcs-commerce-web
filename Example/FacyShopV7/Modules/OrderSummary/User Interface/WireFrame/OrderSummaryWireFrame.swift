//
//  OrderSummaryWireFrame.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Wireframe that handles all routing between views
class OrderSummaryWireFrame: OrderSummaryWireFrameProtocol {
    
    // MARK: OrderSummaryWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentOrderSummaryModule(fromView: AnyObject) {
        
        // Generating module components
        let view: OrderSummaryViewProtocol = OrderSummaryViewController.instantiate() as! OrderSummaryViewProtocol
        let presenter: OrderSummaryPresenterProtocol & OrderSummaryInteractorOutputProtocol = OrderSummaryPresenter()
        let interactor: OrderSummaryInteractorInputProtocol = OrderSummaryInteractor()
        let APIDataManager: OrderSummaryAPIDataManagerInputProtocol = OrderSummaryAPIDataManager()
        let localDataManager: OrderSummaryLocalDataManagerInputProtocol = OrderSummaryLocalDataManager()
        let wireFrame: OrderSummaryWireFrameProtocol = OrderSummaryWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! OrderSummaryViewController
        NavigationHelper.pushViewController(viewController: viewController)
    }
    
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to precheckout data module
    func gotToPreCheckoutData() {
        PreCheckoutDataWireFrame.presentPreCheckoutDataModule(fromView: self)
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods(completion: (() -> Void)?) {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: completion)
    }
}
