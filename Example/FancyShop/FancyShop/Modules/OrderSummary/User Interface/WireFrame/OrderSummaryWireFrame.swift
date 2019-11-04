/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

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
        NavigationHelper.pushViewController(viewController: viewController, animated: true)
    }
    
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods(completion: (() -> Void)?) {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: completion)
    }
    
    /// Goes to transaction Complete module
    func gotoTransactionComplete() {
       TransactionCompleteWireFrame.presentTransactionCompleteModule(fromView: self)
    }
    
    /// Goes to transactoinfailure module
    func goToTransactionFailure() {
        TransactionFailureWireFrame.presentTransactionFailureModule(fromView: self)
    }
    
    /// Goes to confirmOrder module
    func goToConfirmOrderWithPaymentData(paymentData : AnyObject) {
        DispatchQueue.main.async {
            ConfirmOrderWireFrame.presentConfirmOrderModule(fromView: self, paymentData: paymentData)
        }
    }
}

