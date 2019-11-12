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
class ConfirmOrderWireFrame: ConfirmOrderWireFrameProtocol {
    
    // MARK: AllowedCardListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentConfirmOrderModule(fromView: AnyObject, paymentData: AnyObject?) {
        
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
        NavigationHelper.pushViewController(viewController: viewController, animated: false)
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
