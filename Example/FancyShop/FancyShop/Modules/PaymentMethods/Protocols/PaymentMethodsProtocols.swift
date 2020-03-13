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

/// Method contract between PRESENTER -> VIEW
protocol PaymentMethodsViewProtocol: class {
    var presenter: PaymentMethodsPresenterProtocol? { get set }
    func setPaymentMethods(paymentMethods: [NSDictionary])
    func setAddedPaymentMethod(paymentMethod: PaymentMethod)
    func showError(error: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol PaymentMethodsWireFrameProtocol: class {
    static func presentPaymentMethodsModule(fromView view: AnyObject,finalCallback: (() -> Void)?)
    func goBack(animated: Bool)
    func goToLogin()
}

/// Method contract between VIEW -> PRESENTER
protocol PaymentMethodsPresenterProtocol: class {
    var view: PaymentMethodsViewProtocol? { get set }
    var interactor: PaymentMethodsInteractorInputProtocol? { get set }
    var wireFrame: PaymentMethodsWireFrameProtocol? { get set }
    func fetchPaymentMethods()
    func goBack(animated: Bool)
    func paymentMethodSelected(method: String)
    func checkIfPairingShouldBeShown()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol PaymentMethodsInteractorOutputProtocol: class {
    func setPaymentMethods(paymentMethods: [NSDictionary])
    func setAddedPaymentMethod(paymentMethod: PaymentMethod)
    func goBack(animated: Bool)
    func userIsNotLoggedIn()
    func showSDKInitializationError()
    func showSDKAddPaymentMethodError(error: Error)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol PaymentMethodsInteractorInputProtocol: class
{
    var presenter: PaymentMethodsInteractorOutputProtocol? { get set }
    var APIDataManager: PaymentMethodsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: PaymentMethodsLocalDataManagerInputProtocol? { get set }
    
    func fetchPaymentMethods()
    func paymentMethodSelected(method: String)
    func checkIfJustLoggedIn()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol PaymentMethodsDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol PaymentMethodsAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol PaymentMethodsLocalDataManagerInputProtocol: class{
}
