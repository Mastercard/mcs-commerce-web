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
class LoginWireFrame: LoginWireFrameProtocol {
    
    // MARK: LoginWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentLoginModule() {
        
        // Generating module components
        let view: LoginViewProtocol = LoginViewController.instantiate()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
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
        NavigationHelper.pushViewController(viewController: viewController, animated: true)
    }
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods() {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: nil)
    }
}
