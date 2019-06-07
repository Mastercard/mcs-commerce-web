//
//  PreCheckoutDataPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class PreCheckoutDataPresenter:BasePresenter, PreCheckoutDataPresenterProtocol, PreCheckoutDataInteractorOutputProtocol {
    
    //MARK: variables
    weak var view: PreCheckoutDataViewProtocol?
    var interactor: PreCheckoutDataInteractorInputProtocol?
    var wireFrame: PreCheckoutDataWireFrameProtocol?
    let stringsTableName = "PreCheckoutData"
    
    
    //MARK: PreCheckoutDataPresenterProtocol
    
    /// Goes back to the previous screen
    func goBack() {
        self.wireFrame?.goBack()
    }
    
    /// Receives the action to make the express checkout
    ///
    /// - Parameters:
    ///   - card: Selected card
    ///   - shippingAddress: Selected shipping Address
    func expressCheckoutAction(card: Card, shippingAddress: ShippingAddress?,suppressShipping:Bool) {
        self.view?.startAnimating()
        self.interactor?.expressCheckout(card: card, shippingAddress: shippingAddress,suppressShipping:suppressShipping)
    }
    
    // MARK: PreCheckoutDataInteractorOutputProtocol
    
    /// Ask the interactor to fetch the precheckout data
    func fetchData() {
        self.view?.startAnimating()
        self.interactor?.fetchPreCheckoutData()
    }
    
    /// Tells the view to present the precheckout data fetched from one server
    ///
    /// - Parameter preCheckoutData: Precheckout data
    func present(preCheckoutData: PreCheckoutData) {
         DispatchQueue.main.async {
            self.view?.reloadData(cards: preCheckoutData.cards, addresses: preCheckoutData.shippingAddresses)
            self.view?.stopAnimating()
        }
    }
    
    /// If something goes wrong while getting the precheckout this method will be called
    func showPreCheckoutDataError(){
         DispatchQueue.main.async {
            self.view?.stopAnimating()
            self.view?.showError(message: super.localizedString(forKey:"PRECHECKOUT_DATA_NOT_FOUND", fromTable:self.stringsTableName))
        }
    }
    
    /// If something goes wrong while doing the express checkout this method will be called to show the error
    func showExpressCheckoutError() {
         DispatchQueue.main.async {
            self.view?.stopAnimating()
            self.view?.showError(message: super.localizedString(forKey:"EXPRESS_CHECKOUT_FAILED", fromTable:self.stringsTableName))
        }
    }
    
    /// Shows an error if network is not available
    func showNetworkError() {
        self.view?.stopAnimating()
        self.view?.showError(message:super.localizedString(forKey: "INTERNET_ERROR", fromTable: stringsTableName))
    }
    
    /// When the express checkout is done correctly, this method is called
    ///
    /// - Parameter paymentData: Payment data object
    func expressCheckoutDone(paymentData: PaymentData) {
         DispatchQueue.main.async {
            self.view?.stopAnimating()
            self.wireFrame?.goToPaymentDataModule(paymentData: paymentData)
        }
    }
}
