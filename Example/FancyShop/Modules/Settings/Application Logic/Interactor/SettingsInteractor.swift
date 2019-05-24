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
/// SettingsInteractor implements SettingsInteractorInputProtocol protocol, handles the interaction to show the settings and handles the selection
class SettingsInteractor: BaseInteractor, SettingsInteractorInputProtocol {
    
    // MARK: variables
    weak var presenter: SettingsInteractorOutputProtocol?
    var APIDataManager: SettingsAPIDataManagerInputProtocol?
    var localDatamanager: SettingsLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    /// Base initializer
    override init() {}
    
    // MARK: SettingsInteractorInputProtocol
    
    /// Changes the supress shipping status flag
    func suppressShipping() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.suppressShipping = !configuration.suppressShipping
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Changes the checkout with payment method status flag
    func togglePaymentMethodCheckoutOptionOnOff() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.enablePaymentMethodCheckout = !configuration.enablePaymentMethodCheckout
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    /// Returns the saved configuration for all modules
    func getSavedConfig() {
        let conf:SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setSavedData(cards: conf.cards, language: conf.language, currency: conf.currency, shippingStatus: conf.suppressShipping, paymentMethodCheckoutStatus: conf.enablePaymentMethodCheckout)
    }
}
