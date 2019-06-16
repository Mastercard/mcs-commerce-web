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
protocol CurrencyListViewProtocol: class {
    var presenter: CurrencyListPresenterProtocol? { get set }
    func setCurrent(currency: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol CurrencyListWireFrameProtocol: class {
    static func presentCurrencyListModule(fromView view: AnyObject)
    func goBack(_ animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol CurrencyListPresenterProtocol: class {
    var view: CurrencyListViewProtocol? { get set }
    var interactor: CurrencyListInteractorInputProtocol? { get set }
    var wireFrame: CurrencyListWireFrameProtocol? { get set }
    
    func getCurrentCurrency()
    func goBack(_ animated: Bool)
    func currencySelected(currency: String)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol CurrencyListInteractorOutputProtocol: class {
    func setCurrent(currency: String)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol CurrencyListInteractorInputProtocol: class
{
    var presenter: CurrencyListInteractorOutputProtocol? { get set }
    var APIDataManager: CurrencyListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: CurrencyListLocalDataManagerInputProtocol? { get set }
    
    func getCurrentCurrency()
    func currencySelected(currency: String)
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol CurrencyListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol CurrencyListAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol CurrencyListLocalDataManagerInputProtocol: class{
}
