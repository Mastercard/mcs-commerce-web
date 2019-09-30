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

/// AllowedDSRPListInteractor implements AllowedDSRPListInteractorInputProtocol protocol, handles the interaction to save and change the tokenization values
class AllowedDSRPListInteractor: AllowedDSRPListInteractorInputProtocol {
    
    // MARK: Variables
    
    /// AllowedDSRPListInteractorOutputProtocol optional instance
    weak var presenter: AllowedDSRPListInteractorOutputProtocol?
    
    /// AllowedDSRPListAPIDataManagerInputProtocol optional instance
    var APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol?
    
    /// AllowedDSRPListLocalDataManagerInputProtocol optional instance
    var localDatamanager: AllowedDSRPListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    
    // MARK: AllowedDSRPListInteractorInputProtocol Methods
    
    
    /// Fetchs the saved tokenizations and pass them to the presenter
    func fetchDSRPList() {
        self.presenter?.setDSRPList(dsrps: SDKConfiguration.sharedInstance.DSRPs)
    }
    
    
    /// Saves the new preferences about tokenization
    ///
    /// - Parameter dsrps: DSRP array
    func dsrpSelected(dsrps: [DSRP]) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.DSRPs = dsrps
        configuration.saveConfiguration()
    }
}
