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
class SettingsPresenter: BasePresenter, SettingsPresenterProtocol, SettingsInteractorOutputProtocol {

    let stringsTableName = "OrderSummary"
    // MARK: variables
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var wireFrame: SettingsWireFrameProtocol?
    
    // MARK: Initializers
    
    /// Base initializer
    override init() {}
    
    // MARK: SettingsPresenterProtocol
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBackToProductList(animated: Bool) {
        self.wireFrame?.goBackToProductList(animated: animated)
    }
    
    /// Goes to language module
    func goToLanguageList() {
        self.wireFrame?.goToLanguageList()
    }
    
    /// Goes to Allowed card list module
    func gotToAllowedCardList() {
        self.wireFrame?.gotToAllowedCardList()
    }
    
    /// Goes to Currency list module
    func gotToCurrencyList() {
        self.wireFrame?.gotToCurrencyList()
    }
    
    /// Changes the suppress shipping flag status
    func suppressShippingAction() {
        self.interactor?.suppressShipping()
    }
    
    /// Changes the checkout with payment method flag status
    func togglePaymentMethodCheckoutOptionOnOff() {
        self.interactor?.togglePaymentMethodCheckoutOptionOnOff()
    }
    
    ///select payment method flag status
    func selectPaymentMethod() {
        self.wireFrame?.goToPaymentMethods(completion: {
        })
    }
    
    func toggleMasterpassFlowOnOff() {
        self.interactor?.toggleMasterpassFlowOnOff()
    }
    
    /// Goes to Allowed DSRP module
    func gotToAllowedDSRPList() {
        self.wireFrame?.gotToAllowedDSRPList()
    }
    
    /// Ask for the saved configuration
    func getSavedConfig() {
        self.interactor?.getSavedConfig()
    }
    
    // MARK: SettingsInteractorOutputProtocol
    
    /// Passes the saved configuration to the view
    ///
    /// - Parameters:
    ///   - cards: Cards array
    ///   - language: selected language
    ///   - currency: selected currency
    ///   - shippingStatus: shipping status flag
    ///   - paymentMethodStatus: payment Method enable flag
    ///   - isMasterpassCheckoutFlow: Masterpass flow flag
    func setSavedData(cards: [CardConfiguration], language: LanguageConfiguration, currency: String, shippingStatus: Bool, paymentMethodCheckoutStatus: Bool, isMasterpassCheckoutFlow: Bool) {
        self.view?.setSavedData(cards: cards, language: language, currency: currency, shippingStatus: shippingStatus, paymentMethodCheckoutStatus: paymentMethodCheckoutStatus, isMasterpassCheckoutFlow: isMasterpassCheckoutFlow)
    }
    
    /// Goes to login module
    func userNotLoggedIn() {
        self.wireFrame?.goToLogin()
    }
    
    /// Animates the view when SDK Initialization start
    func initializeSDK() {
        self.view?.startAnimating()
    }
    
    /// Animates the view when SDK Initialization Complete
    func initializeSDKComplete() {
        self.view?.stopAnimating()
    }
    
    /// Shows an error if the SDK has issues to initialize
    func showSDKInitializationError() {
        self.view?.showError(error:super.localizedString(forKey: "SDK_INITIALIZATION_ERROR", fromTable: stringsTableName))
    }
}
