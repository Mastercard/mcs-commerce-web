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
class AllowedDSRPListPresenter:BasePresenter, AllowedDSRPListPresenterProtocol, AllowedDSRPListInteractorOutputProtocol {
    
    // MARK: Variables
    
    /// AllowedDSRPListViewProtocol optional variable
    weak var view: AllowedDSRPListViewProtocol?
    /// AllowedDSRPListInteractorInputProtocol optional variable
    var interactor: AllowedDSRPListInteractorInputProtocol?
    /// AllowedDSRPListWireFrameProtocol optional variable
    var wireFrame: AllowedDSRPListWireFrameProtocol?
    
    // MARK: AllowedDSRPListPresenterProtocol methods
    
    
    /// Tells the wireframe to go back
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
    
    /// Tells the interactor to fetch the tokenization options
    func fetchDSRPList() {
        self.interactor?.fetchDSRPList()
    }
    
    /// Tells the interactor to save the new preferences
    ///
    /// - Parameter dsrps: DSRP array
    func dsrpSelectedAction(dsrps: [DSRP]) {
        self.interactor?.dsrpSelected(dsrps: dsrps)
    }
    // MARK: AllowedDSRPListInteractorOutputProtocol methods
    func setDSRPList(dsrps: [DSRP]) {
        self.view?.setDSRPList(dsrps: dsrps)
    }
}
