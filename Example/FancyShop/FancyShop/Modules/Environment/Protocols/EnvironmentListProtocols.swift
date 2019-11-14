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
protocol EnvironmentListViewProtocol: class {
    var presenter: EnvironmentListPresenterProtocol? { get set }
    func setCurrent(environment: Constants.envEnum)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol EnvironmentListWireFrameProtocol: class {
    static func presentEnvironmentListModule(fromView view: AnyObject)
    func goBack(_ animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol EnvironmentListPresenterProtocol: class {
    var view: EnvironmentListViewProtocol? { get set }
    var interactor: EnvironmentListInteractorInputProtocol? { get set }
    var wireFrame: EnvironmentListWireFrameProtocol? { get set }
    
    func getCurrentEnvironment()
    func goBack(_ animated: Bool)
    func environmentSelected(environment: Constants.envEnum)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol EnvironmentListInteractorOutputProtocol: class {
    func setCurrent(environment: Constants.envEnum)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol EnvironmentListInteractorInputProtocol: class
{
    var presenter: EnvironmentListInteractorOutputProtocol? { get set }
    func getCurrentEnvironment()
    func environmentSelected(environment: Constants.envEnum)
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol EnvironmentListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol EnvironmentListAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol EnvironmentListLocalDataManagerInputProtocol: class{
}
