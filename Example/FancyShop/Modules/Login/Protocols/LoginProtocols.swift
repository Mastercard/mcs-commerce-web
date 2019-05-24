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
protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    func loginDone()
    func stopAnimation()
    func show(error: String)
    func showError(error: String)
    func userAlreadyLoggedIn(user: User)
    func userNotLoggedIn()
}

/// Method contract between PRESENTER -> WIREFRAME
protocol LoginWireFrameProtocol: class {
    static func presentLoginModule()
    func goBack(animated: Bool)
    func goToPaymentMethods()
}

/// Method contract between VIEW -> PRESENTER
protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    func initializeMasterpassSDK()
    func doLogin(username: String, password: String)
    func goToPaymentMethods()
    func goBack(animated: Bool)
    func doLogout()
    func checkLogin()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol LoginInteractorOutputProtocol: class {
    func loginDone()
    func showEmptyUsernameOrPasswordError()
    func showWrongCredentialsError()
    func userAlreadyLoggedIn(user: User)
    func userNotLoggedIn()
    func goBack(animated: Bool)
    func showSDKInitializationError()
    func stopAnimation()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol LoginInteractorInputProtocol: class
{
    var presenter: LoginInteractorOutputProtocol? { get set }
    var APIDataManager: LoginAPIDataManagerInputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    /**
     * Add here your methods for communication
     */
    func initializeMasterpassSDK()
    func doLogin(username: String, password: String)
    func doLogout()
    func checkLogin()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol LoginDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol LoginAPIDataManagerInputProtocol: class{
    func doLogin(username: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ())
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol LoginLocalDataManagerInputProtocol: class{
}
