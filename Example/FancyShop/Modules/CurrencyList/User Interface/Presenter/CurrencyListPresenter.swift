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
class CurrencyListPresenter: CurrencyListPresenterProtocol, CurrencyListInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var wireFrame: CurrencyListWireFrameProtocol?
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    //MARK: CurrencyListPresenterProtocol
    
    /// Ask for the current currency
    func getCurrentCurrency() {
        self.interactor?.getCurrentCurrency()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        self.wireFrame?.goBack(animated)
    }
    
    /// Tells the interactor that a currency has been selected
    ///
    /// - Parameter currency: String with the currency
    func currencySelected(currency: String) {
        self.interactor?.currencySelected(currency: currency)
    }
    
    //MARK: CurrencyListInteractorOutputProtocol
    
    /// Tells the view to show the current curency
    ///
    /// - Parameter currency: String with the currency
    func setCurrent(currency: String) {
        self.view?.setCurrent(currency: currency)
    }
}
