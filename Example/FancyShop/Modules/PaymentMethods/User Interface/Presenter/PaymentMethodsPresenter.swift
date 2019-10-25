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
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class PaymentMethodsPresenter:BasePresenter, PaymentMethodsPresenterProtocol, PaymentMethodsInteractorOutputProtocol {
    
    //MARK: variables
    weak var view: PaymentMethodsViewProtocol?
    var interactor: PaymentMethodsInteractorInputProtocol?
    var wireFrame: PaymentMethodsWireFrameProtocol?
    let stringsTableName = "PaymentMethods"
    
    // MARK: PaymentMethodsInteractorOutputProtocol
    
    /// Sets the payment methods to the view
    ///
    /// - Parameter paymentMethods: NSDictionary array
    func setPaymentMethods(paymentMethods: [NSDictionary]) {
        self.view?.setPaymentMethods(paymentMethods: paymentMethods)
    }
    /// Sets the added payment method to the view
    ///
    /// - Parameter paymentMethod: NSDictionary array
    func setAddedPaymentMethod(paymentMethod: PaymentMethod) {
        self.view?.setAddedPaymentMethod(paymentMethod: paymentMethod)
    }
    /// Ask the interactor to check if it needs to go to the pairing mode
    func checkIfPairingShouldBeShown() {
        self.interactor?.checkIfJustLoggedIn()
    }
        
    // MARK: PaymentMethodsPresenterProtocol
    
    /// Ask the interactor for the payment methods
    func fetchPaymentMethods() {
        self.interactor?.fetchPaymentMethods()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
    
    /// Payment method selected handler
    ///
    /// - Parameter method: payment method
    func paymentMethodSelected(method: String) {
        self.interactor?.paymentMethodSelected(method: method)
    }
    
    /// Goes to the login module
    func userIsNotLoggedIn() {
        self.wireFrame?.goToLogin()
    }
    
    /// Shows an error if there is something wrong while initializing the sdk
    func showSDKInitializationError() {
        self.view?.showError(error: super.localizedString(forKey:"SDK_INITIALIZATION_ERROR", fromTable: stringsTableName));
    }
    
    /// Shows an error if there is something wrong while initializing the sdk
    func showSDKAddPaymentMethodError(error: Error) {
        self.view?.showError(error: error.localizedDescription);
    }
}
