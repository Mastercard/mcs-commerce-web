//
//  AllowedCardListInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Handles allowed cards logic, implements AllowedCardListInteractorInputProtocol protocol, responsable of save and retrieve them from the Configuration object
class AllowedCardListInteractor: AllowedCardListInteractorInputProtocol {
    
    
    // MARK: Variables
    
    /// AllowedCardListInteractorOutputProtocol optional instance
    weak var presenter: AllowedCardListInteractorOutputProtocol?
    
    /// AllowedCardListAPIDataManagerInputProtocol optional instance
    var APIDataManager: AllowedCardListAPIDataManagerInputProtocol?
    
    /// AllowedCardListLocalDataManagerInputProtocol optional instance
    var localDatamanager: AllowedCardListLocalDataManagerInputProtocol?
    
    
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    
    // MARK: AllowedCardListInteractorInputProtocol methods
    
    /// It will fetch the cards saved previously on the configuration object
    func fetchCardList() {
        self.presenter?.setCardList(cards: SDKConfiguration.sharedInstance.cards)
    }
    
    /// Saves the selected cards in the configuration object
    ///
    /// - Parameter cards: array of cards selected
    func cardSelected(cards: [CardConfiguration]) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.cards = cards
        configuration.saveConfiguration()
    }
    
    /// Evaluates if at least one card is selected, otherwise it will throw an error
    ///
    /// - Parameter animated: used to animate the view pop
    func shouldGoBack(animated: Bool) -> Bool {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        if configuration.isCardSelected() {
            self.presenter?.goBack(animated: animated)
            return true
        }else{
            self.presenter?.showCardNotSelectedError()
            return false
        }
    }
}
