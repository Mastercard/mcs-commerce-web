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
protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol? { get set }
    
    func setSavedData(cards: [CardConfiguration], language: LanguageConfiguration, currency: String, shippingStatus: Bool, paymentMethodCheckoutStatus: Bool, isMasterpassCheckoutFlow: Bool)
    func startAnimating()
    func stopAnimating()
    func showError(error: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol SettingsWireFrameProtocol: class {
    static func presentSettingsModule(fromView view: AnyObject)
    
    func goBackToProductList(animated: Bool)
    func goToLanguageList()
    func gotToAllowedCardList()
    func gotToAllowedDSRPList()
    func gotToCurrencyList()
    func goToLogin()
    func goToPaymentMethods(completion: (() -> Void)?)
}

/// Method contract between VIEW -> PRESENTER
protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var wireFrame: SettingsWireFrameProtocol? { get set }
    func goBackToProductList(animated: Bool)
    func goToLanguageList()
    func gotToAllowedCardList()
    func gotToCurrencyList()
    func suppressShippingAction()
    func togglePaymentMethodCheckoutOptionOnOff()
    func gotToAllowedDSRPList()
    func getSavedConfig()
    func selectPaymentMethod()
    func toggleMasterpassFlowOnOff()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol SettingsInteractorOutputProtocol: class {
    func setSavedData(cards: [CardConfiguration], language: LanguageConfiguration,  currency: String, shippingStatus: Bool, paymentMethodCheckoutStatus: Bool, isMasterpassCheckoutFlow: Bool)
    func userNotLoggedIn()
    func initializeSDK()
    func initializeSDKComplete()
    func selectPaymentMethod()
    func showSDKInitializationError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol SettingsInteractorInputProtocol: class
{
    var presenter: SettingsInteractorOutputProtocol? { get set }
    var APIDataManager: SettingsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: SettingsLocalDataManagerInputProtocol? { get set }
    func suppressShipping()
    func togglePaymentMethodCheckoutOptionOnOff()
    func toggleMasterpassFlowOnOff()
    func getSavedConfig()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol SettingsDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol SettingsAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol SettingsLocalDataManagerInputProtocol: class{
}
