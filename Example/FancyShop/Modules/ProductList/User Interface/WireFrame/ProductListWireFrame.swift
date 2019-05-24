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
import UIKit
/// Wireframe that handles all routing between views
class ProductListWireFrame: ProductListWireFrameProtocol {
    // MARK: ProductListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentProductListModule(fromView: AnyObject){
        
        // Generating module components
        let view: ProductListViewProtocol = ProductListViewController.instantiate()
        let presenter: ProductListPresenterProtocol & ProductListInteractorOutputProtocol = ProductListPresenter()
        let interactor: ProductListInteractorInputProtocol = ProductListInteractor()
        let APIDataManager: ProductListAPIDataManagerInputProtocol = ProductListAPIDataManager()
        let localDataManager: ProductListLocalDataManagerInputProtocol = ProductListLocalDataManager()
        let wireFrame: ProductListWireFrameProtocol = ProductListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        
        //Since is the first view controller, we need to set the navigation controller too
        let viewController = view as! ProductListViewController
        NavigationHelper.setRootViewController(withViewController: viewController);
    }
    
    /// Goes to settings module
    func presentSettingsModule() {
        SettingsWireFrame.presentSettingsModule(fromView: self)
    }
    
    /// Goes to confirm order module
    func presentConfirmOrderModule() {
        OrderSummaryWireFrame.presentOrderSummaryModule(fromView: self)
    }
    
    /// Goes to login module
    func goToLogin() {
        LoginWireFrame.presentLoginModule()
    }
}
