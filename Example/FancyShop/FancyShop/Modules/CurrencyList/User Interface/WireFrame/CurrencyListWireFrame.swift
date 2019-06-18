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
class CurrencyListWireFrame: CurrencyListWireFrameProtocol {
    
    // MARK: CurrencyListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentCurrencyListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: CurrencyListViewProtocol = CurrencyListViewController.instantiate() as! CurrencyListViewProtocol
        let presenter: CurrencyListPresenterProtocol & CurrencyListInteractorOutputProtocol = CurrencyListPresenter()
        let interactor: CurrencyListInteractorInputProtocol = CurrencyListInteractor()
        let APIDataManager: CurrencyListAPIDataManagerInputProtocol = CurrencyListAPIDataManager()
        let localDataManager: CurrencyListLocalDataManagerInputProtocol = CurrencyListLocalDataManager()
        let wireFrame: CurrencyListWireFrameProtocol = CurrencyListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! CurrencyListViewController
        NavigationHelper.pushViewController(viewController:viewController, animated: true)
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
