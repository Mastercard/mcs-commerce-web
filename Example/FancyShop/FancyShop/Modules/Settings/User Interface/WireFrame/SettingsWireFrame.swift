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
class SettingsWireFrame: SettingsWireFrameProtocol {
    
    // MARK: SettingsWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentSettingsModule(fromView: AnyObject) {
        
        // Generating module components
        let view: SettingsViewProtocol = SettingsViewController.instantiate()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        let APIDataManager: SettingsAPIDataManagerInputProtocol = SettingsAPIDataManager()
        let localDataManager: SettingsLocalDataManagerInputProtocol = SettingsLocalDataManager()
        let wireFrame: SettingsWireFrameProtocol = SettingsWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        
        let viewController = view as! SettingsViewController
        NavigationHelper.pushViewController(viewController:viewController, animated: true)
    }
    
    /// Goes to the previous screen
    ///
    /// - Parameter animated: Animation flag
    func goBackToProductList(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
    
    /// Goes to language list module
    func goToLanguageList() {
        LanguageListWireFrame.presentLanguageListModule(fromView: self)
    }
    
    /// Goes to Currency List module
    func gotToCurrencyList() {
        CurrencyListWireFrame.presentCurrencyListModule(fromView: self)
    }
    
    /// Goes to Allowed Card List module
    func gotToAllowedCardList() {
        AllowedCardListWireFrame.presentAllowedCardListModule(fromView: self)
    }
    
    /// Goes to Allowed DSRP module
    func gotToAllowedDSRPList() {
        AllowedDSRPListWireFrame.presentAllowedDSRPListModule(fromView: self)
    }
    
    /// Goes to login module
    func goToLogin() {
        LoginWireFrame.presentLoginModule()
    }
    
    /// Goes to payment methods module
    func goToPaymentMethods(completion: (() -> Void)?) {
        PaymentMethodsWireFrame.presentPaymentMethodsModule(fromView: self, finalCallback: completion)
    }
    
    /// Goes to Environment List module
    func gotToEnvironmentList() {
        EnvironmentListWireFrame.presentEnvironmentListModule(fromView: self)
        
    }
}
