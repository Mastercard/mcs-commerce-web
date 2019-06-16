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
class AllowedDSRPListWireFrame: AllowedDSRPListWireFrameProtocol {
    
    // MARK: AllowedDSRPListWireFrameProtocol
    
    /// Static method that initializes every class needed
    ///
    /// - Parameter fromView: default parameter
    class func presentAllowedDSRPListModule(fromView: AnyObject) {
        
        // Generating module components
        let view: AllowedDSRPListViewProtocol = AllowedDSRPListViewController.instantiate()
        let presenter: AllowedDSRPListPresenterProtocol & AllowedDSRPListInteractorOutputProtocol = AllowedDSRPListPresenter()
        let interactor: AllowedDSRPListInteractorInputProtocol = AllowedDSRPListInteractor()
        let APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol = AllowedDSRPListAPIDataManager()
        let localDataManager: AllowedDSRPListLocalDataManagerInputProtocol = AllowedDSRPListLocalDataManager()
        let wireFrame: AllowedDSRPListWireFrameProtocol = AllowedDSRPListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let viewController = view as! AllowedDSRPListViewController
        NavigationHelper.pushViewController(viewController:viewController, animated: true)
    }
    
    /// Goes back to the previous view
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        NavigationHelper.singleBack(animated: animated)
    }
}
