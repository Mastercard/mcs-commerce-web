//
//  LoginPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class LoginPresenter:BasePresenter, LoginPresenterProtocol, LoginInteractorOutputProtocol {
  
    // MARK: Variables
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    let stringsTableName = "Login"
    
    // MARK: LoginPresenterProtocol
    
    /// Animates the view when SDK Initialization start
    func initializeSDK() {
        self.view?.startAnimating()
    }
    
    /// Animates the view when SDK Initialization Complete
    func initializeSDKComplete() {
        self.view?.stopAnimating()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
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
    
    /// Shows an error if network is not available
    func showNetworkError() {
        stopAnimation()
        self.view?.showError(error:super.localizedString(forKey: "INTERNET_ERROR", fromTable: stringsTableName))
    }
    
    /// Stops animation
    func stopAnimation() {
        self.view?.stopAnimating()
    }
    
    ///select payment method flag status
    func selectPaymentMethod() {
        self.interactor?.selectPaymentMethod()
    }
    
    func paymentMethod() {
        
        self.wireFrame?.goToPaymentMethods(completion: {
            
        })
    }
}
