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
protocol AllowedDSRPListViewProtocol: class {
    var presenter: AllowedDSRPListPresenterProtocol? { get set }
    func setDSRPList(dsrps: [DSRP])
}


/// Method contract between PRESENTER -> WIREFRAME
protocol AllowedDSRPListWireFrameProtocol: class {
    static func presentAllowedDSRPListModule(fromView view: AnyObject)
    func goBack(animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol AllowedDSRPListPresenterProtocol: class {
    var view: AllowedDSRPListViewProtocol? { get set }
    var interactor: AllowedDSRPListInteractorInputProtocol? { get set }
    var wireFrame: AllowedDSRPListWireFrameProtocol? { get set }
    
    func fetchDSRPList()
    func goBack(animated: Bool)
    func dsrpSelectedAction(dsrps: [DSRP])
}

/// Method contract between INTERACTOR -> PRESENTER
protocol AllowedDSRPListInteractorOutputProtocol: class {
    func setDSRPList(dsrps: [DSRP])
}


/// Method contract between PRESENTER -> INTERACTOR
protocol AllowedDSRPListInteractorInputProtocol: class{
    var presenter: AllowedDSRPListInteractorOutputProtocol? { get set }
    var APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AllowedDSRPListLocalDataManagerInputProtocol? { get set }
    
    func fetchDSRPList()
    func dsrpSelected(dsrps: [DSRP])
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol AllowedDSRPListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol AllowedDSRPListAPIDataManagerInputProtocol: class{
}

/// Method contract between communication INTERACTOR -> LOCALDATAMANAGER
protocol AllowedDSRPListLocalDataManagerInputProtocol: class{
}
