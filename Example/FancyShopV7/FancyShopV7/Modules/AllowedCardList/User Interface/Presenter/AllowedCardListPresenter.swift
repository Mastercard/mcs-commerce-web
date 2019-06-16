//
//  AllowedCardListPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class AllowedCardListPresenter:BasePresenter, AllowedCardListPresenterProtocol, AllowedCardListInteractorOutputProtocol {
    
    
    // MARK: Variables
    
    /// AllowedCardListViewProtocol optional variable
    weak var view: AllowedCardListViewProtocol?
    /// AllowedCardListInteractorInputProtocol optional variable
    var interactor: AllowedCardListInteractorInputProtocol?
    /// AllowedCardListWireFrameProtocol optional variable
    var wireFrame: AllowedCardListWireFrameProtocol?
    /// static string used to point to the strings file
    let stringsTableName = "AllowedCardList"
    
    // MARK: AllowedCardListPresenterProtocol
    
    /// Passes the responsability to the interactor to evaluate if the user can go back
    ///
    /// - Parameter animated: animation flag
    func shouldGoBack(animated: Bool) {
        _ = self.interactor?.shouldGoBack(animated: animated)
    }
    
    /// Called when there is no card enabled/selected
    /// It will show an error message taken from the strings files
    func showCardNotSelectedError() {
        self.view?.showError(error:super.localizedString(forKey: "NO_CARD_SELECTED_ERROR", fromTable: stringsTableName))
    }
    
    /// Tells the interactor to fetch the card list
    func fetchCardList() {
        self.interactor?.fetchCardList()
    }
    // Passes the cards array to the interactor
    func cardSelectedAction(cards: [CardConfiguration]) {
        self.interactor?.cardSelected(cards: cards)
    }
    
    // MARK: AllowedCardListInteractorOutputProtocol
    func setCardList(cards: [CardConfiguration]) {
        self.view?.setCardList(cards: cards)
    }
    
    /// Tells the wireframe to dismiss the current view from the stack
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
}
