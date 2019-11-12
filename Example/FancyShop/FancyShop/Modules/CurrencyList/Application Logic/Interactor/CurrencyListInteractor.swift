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
/// Handles selected currency logic, implements CurrencyListInteractorInputProtocol protocol, responsable of save and retrieve the used currency
class CurrencyListInteractor: CurrencyListInteractorInputProtocol {
    
    // MARK: Variables
    
    /// CurrencyListInteractorOutputProtocol optional instance
    weak var presenter: CurrencyListInteractorOutputProtocol?
    
    /// CurrencyListAPIDataManagerInputProtocol optional instance
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol?
    
    /// CurrencyListLocalDataManagerInputProtocol optional instance
    var localDatamanager: CurrencyListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    // MARK: CurrencyListInteractorInputProtocol
    
    /// Gets the currency from the configuration and pass it to the presenter
    func getCurrentCurrency() {
        let config: SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setCurrent(currency: config.currency)
    }
    
    /// Saves the new currency in the configuration
    ///
    /// - Parameter currency: String
    func currencySelected(currency: String) {
        SDKConfiguration.sharedInstance.setCurrency(currency: currency)
    }
}
