//
//  PaymentMethodsPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class PaymentMethodsPresenter:BasePresenter, PaymentMethodsPresenterProtocol, PaymentMethodsInteractorOutputProtocol {
    
    //MARK: variables
    weak var view: PaymentMethodsViewProtocol?
    var interactor: PaymentMethodsInteractorInputProtocol?
    var wireFrame: PaymentMethodsWireFrameProtocol?
    let stringsTableName = "PaymentMethods"
    
    // MARK: PaymentMethodsInteractorOutputProtocol
    
    /// Sets the payment methods to the view
    ///
    /// - Parameter paymentMethods: NSDictionary array
    func setPaymentMethods(paymentMethods: [NSDictionary]) {
        self.view?.setPaymentMethods(paymentMethods: paymentMethods)
    }
    /// Sets the added payment method to the view
    ///
    /// - Parameter paymentMethod: NSDictionary array
    func setAddedPaymentMethod(paymentMethod: PaymentMethod) {
        self.view?.setAddedPaymentMethod(paymentMethod: paymentMethod)
    }
    /// Ask the interactor to check if it needs to go to the pairing mode
    func checkIfPairingShouldBeShown() {
        self.interactor?.checkIfJustLoggedIn()
    }
    
    /// Sets if the user has a pairing id
    ///
    /// - Parameter hasPairingId: boolean flag
    func setUser(hasPairingId: Bool) {
        self.view?.setUser(hasPairingId: hasPairingId)
    }
    
    /// Sets if the user has a transaction pairing id
    ///
    /// - Parameter hasTransactionPairingId: boolean flag
    func setUser(hasTransactionPairingId: Bool) {
        self.view?.setUser(hasTransactionPairingId: hasTransactionPairingId)
    }
    
    // MARK: PaymentMethodsPresenterProtocol
    
    /// Ask the interactor for the payment methods
    func fetchPaymentMethods() {
        self.interactor?.fetchPaymentMethods()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
    
    /// Payment method selected handler
    ///
    /// - Parameter method: payment method
    func paymentMethodSelected(method: String) {
        self.interactor?.paymentMethodSelected(method: method)
    }
    
    /// Goes to the login module
    func userIsNotLoggedIn() {
        self.wireFrame?.goToLogin()
    }
    
    /// Shows an error if there is something wrong while initializing the sdk
    func showSDKInitializationError() {
        self.view?.showError(error: super.localizedString(forKey:"SDK_INITIALIZATION_ERROR", fromTable: stringsTableName));
    }
    
    /// Shows an error if there is something wrong while initializing the sdk
    func showSDKAddPaymentMethodError(error: Error) {
        self.view?.showError(error: error.localizedDescription);
    }
}
