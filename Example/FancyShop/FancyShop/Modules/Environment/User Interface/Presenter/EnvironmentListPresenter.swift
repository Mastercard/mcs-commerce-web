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
class EnvironmentListPresenter: EnvironmentListPresenterProtocol, EnvironmentListInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: EnvironmentListViewProtocol?
    var interactor: EnvironmentListInteractorInputProtocol?
    var wireFrame: EnvironmentListWireFrameProtocol?
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    //MARK: EnvironmentListPresenterProtocol
    
    /// Ask for the environment currency
    func getCurrentEnvironment() {
        self.interactor?.getCurrentEnvironment()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        self.wireFrame?.goBack(animated)
    }
    
    /// Tells the interactor that a currency has been selected
    ///
    /// - Parameter environment: String with the environment
    func environmentSelected(environment: Constants.envEnum) {
        self.interactor?.environmentSelected(environment: environment)
    }
    
    //MARK: EnvironmentListInteractorOutputProtocol
    
    /// Tells the view to show the current environment
    ///
    /// - Parameter environment: String with the environment
    func setCurrent(environment: Constants.envEnum) {
        self.view?.setCurrent(environment: environment)
    }
}
