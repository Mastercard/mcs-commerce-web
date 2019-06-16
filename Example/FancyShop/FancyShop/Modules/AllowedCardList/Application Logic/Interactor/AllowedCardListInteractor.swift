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
