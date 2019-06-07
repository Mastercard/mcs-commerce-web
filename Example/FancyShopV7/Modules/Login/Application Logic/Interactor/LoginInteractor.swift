//
//  LoginInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// LoginInteractor implements LoginInteractorInputProtocol protocol, handles the interaction to make a login and save the user data
class LoginInteractor: BaseInteractor, LoginInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: LoginInteractorOutputProtocol?
    var APIDataManager: LoginAPIDataManagerInputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var isEnablingExpressCheckout:Bool
    
    // MARK: Initializers
    
    /// Initializer that saves the isEnablingExpressCheckout flag
    ///
    /// - Parameter isEnablingExpressCheckout: Used to see if the login is raised because is needed for a express checkout
    init(isEnablingExpressCheckout:Bool) {
        self.isEnablingExpressCheckout = isEnablingExpressCheckout
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
            if NetworkReachability.isNetworkRechable() {
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
                        if self.isEnablingExpressCheckout{
                            let configuration:SDKConfiguration = SDKConfiguration.sharedInstance
                            configuration.enableExpressCheckout = true
                        }
                        self.presenter?.loginDone()
                    }else {
                        self.presenter?.showWrongCredentialsError()
                    }
                })
            } else {
                self.presenter?.showNetworkError()
            }
        }
    }
    
    /// Does a logout for the user and deletes all data stored for the same
    func doLogout() {
        let user: User = User.sharedInstance
        user.doLogout()
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.enableExpressCheckout = false
        configuration.enablePairingWithCheckout = false
        configuration.saveConfiguration()
        self.presenter?.userNotLoggedIn()
    }
    
    func selectPaymentMethod() {
        
        if NetworkReachability.isNetworkRechable() {
            let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
            self.presenter?.initializeSDK()
            super.initSDK(isPairingOnly: false, isExpressEnable: configuration.enableExpressCheckout) { responseObject, error in
                
                DispatchQueue.main.async {
                    self.presenter?.initializeSDKComplete()
                    let status: String = responseObject?.value(forKey: "status") as! String
                    if status == Constants.status.OK {
                        
                        self.presenter?.paymentMethod()
                        
                    } else if status == Constants.status.NOK && error != nil {
                        
                        self.presenter?.showSDKInitializationError()
                    }
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
}
