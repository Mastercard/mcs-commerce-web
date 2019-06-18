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

/// LoginInteractor implements LoginInteractorInputProtocol protocol, handles the interaction to make a login and save the user data
class LoginInteractor: BaseInteractor, LoginInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: LoginInteractorOutputProtocol?
    var APIDataManager: LoginAPIDataManagerInputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    // MARK: Merchant SDK initialization
    func initializeMasterpassSDK() {
        
        super.initSDK { (error) in
            
            if (error != nil) {
               self.presenter?.showSDKInitializationError()
            }
            self.presenter?.stopAnimation()
        }
    }
    
    /// If the user is logged in or not
    func checkLogin() {
        let user: User = User.sharedInstance
        if user.isLoggedIn() {
            self.presenter?.userAlreadyLoggedIn(user: user)
        } else {
            self.presenter?.userNotLoggedIn()
        }
    }
    
    /// Makes the login request and handles the response as needed
    ///
    /// - Parameters:
    ///   - username: String with the Username
    ///   - password: String with the Password
    func doLogin(username: String, password: String) {
        if username.isEmpty || password.isEmpty{
            self.presenter?.showEmptyUsernameOrPasswordError()
        }else{
            APIDataManager?.doLogin(username: username, password: password, completionHandler: { responseObject, error in
                let status: String = responseObject?.value(forKey: "status") as! String
                if status == Constants.status.OK{
                    let jsonData = responseObject?.value(forKey: "data") as! NSDictionary
                    let user: User = User.sharedInstance
                    user.firstName = jsonData.value(forKey: "firstName") as? String
                    user.lastName = jsonData.value(forKey: "lastName") as? String
                    user.userId = "\(jsonData.value(forKey: "userId")!)"
                    user.username = jsonData.value(forKey: "username") as? String
                    user.saveUser()
                    self.presenter?.loginDone()
                }else {
                    self.presenter?.showWrongCredentialsError()
                }
            })
        }
    }
    
    /// Does a logout for the user and deletes all data stored for the same
    func doLogout() {
        let user: User = User.sharedInstance
        user.doLogout()
        self.presenter?.userNotLoggedIn()
    }
}
