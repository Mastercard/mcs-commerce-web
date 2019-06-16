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
class LoginPresenter:BasePresenter, LoginPresenterProtocol, LoginInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    let stringsTableName = "Login"
    let kPaymentMethodStringsTableName = "PaymentMethods"
    
    // MARK: LoginPresenterProtocol
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
    
    /// Merchant SDK initialization
    func initializeMasterpassSDK() {
        self.interactor?.initializeMasterpassSDK()
    }
    
    
    /// Passes the parameters needed to make a login to the interactor
    ///
    /// - Parameters:
    ///   - username: String username
    ///   - password: String password
    func doLogin(username: String, password: String) {
        self.interactor?.doLogin(username: username, password: password)
    }
    
    // MARK: LoginInteractorOutputProtocol
    
    /// Called after a successful login has been made
    func loginDone() {
        self.view?.loginDone()
    }
    
    /// Tells the interactor to check the login status
    func checkLogin() {
        self.interactor?.checkLogin()
    }
    
    /// Ask the interactor to do a logout of the current user
    func doLogout() {
        self.interactor?.doLogout()
    }
    
    /// Called if user has already Logged In
    func userAlreadyLoggedIn(user: User) {
        self.view?.userAlreadyLoggedIn(user: user)
    }
    
    /// Called if user not Logged In
    func userNotLoggedIn() {
        self.view?.userNotLoggedIn()
    }
    
    /// Called when the username or password is nil or empty
    func showEmptyUsernameOrPasswordError() {
        self.view?.show(error: super.localizedString(forKey:"EMPTY_USERNAME_OR_PASSWORD", fromTable: stringsTableName))
    }
    
    /// Called when the login fails
    func showWrongCredentialsError() {
        self.view?.show(error: super.localizedString(forKey:"WRONG_CREDENTIALS", fromTable: stringsTableName))
    }
    
    /// Shows an error if the SDK has issues to initialize
    func showSDKInitializationError() {
        self.view?.showError(error:super.localizedString(forKey: "SDK_INITIALIZATION_ERROR", fromTable: kPaymentMethodStringsTableName))
    }
    
    /// Stops animation
    func stopAnimation() {
        self.view?.stopAnimation()
    }
    
    
    /// Goes to Payment method module
    func goToPaymentMethods() {
        self.wireFrame?.goToPaymentMethods()
    }
    
}
