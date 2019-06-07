//
//  LoginProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Method contract between PRESENTER -> VIEW
protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    func loginDone()
    func startAnimating()
    func stopAnimating()
    func show(error: String)
    func showError(error: String)
    func userAlreadyLoggedIn(user: User)
    func userNotLoggedIn()
}

/// Method contract between PRESENTER -> WIREFRAME
protocol LoginWireFrameProtocol: class {
    static func presentLoginModule(isEnablingExpressCheckout: Bool)
    func goBack(animated: Bool)
    func goToPaymentMethods(completion: (() -> Void)?)
}

/// Method contract between VIEW -> PRESENTER
protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    func doLogin(username: String, password: String)
    func goBack(animated: Bool)
    func doLogout()
    func checkLogin()
    func selectPaymentMethod()
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
    func paymentMethod()
    func initializeSDK()
    func initializeSDKComplete()
    func showNetworkError()
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
    func doLogin(username: String, password: String)
    func doLogout()
    func checkLogin()
    func selectPaymentMethod()
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
