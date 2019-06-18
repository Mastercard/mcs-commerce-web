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

/// Method contract between PRESENTER -> VIEW
protocol AllowedCardListViewProtocol: class {
    var presenter: AllowedCardListPresenterProtocol? { get set }
    func setCardList(cards: [CardConfiguration])
    func showError(error: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol AllowedCardListWireFrameProtocol: class {
    static func presentAllowedCardListModule(fromView view: AnyObject)
    func goBack(animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol AllowedCardListPresenterProtocol: class {
    var view: AllowedCardListViewProtocol? { get set }
    var interactor: AllowedCardListInteractorInputProtocol? { get set }
    var wireFrame: AllowedCardListWireFrameProtocol? { get set }
    
    func fetchCardList()
    func shouldGoBack(animated: Bool)
    func cardSelectedAction(cards: [CardConfiguration])
}

/// Method contract between INTERACTOR -> PRESENTER
protocol AllowedCardListInteractorOutputProtocol: class {
    
    func setCardList(cards: [CardConfiguration])
    func goBack(animated: Bool)
    func showCardNotSelectedError()
}
/// Method contract between PRESENTER -> INTERACTOR
protocol AllowedCardListInteractorInputProtocol: class
{
    var presenter: AllowedCardListInteractorOutputProtocol? { get set }
    var APIDataManager: AllowedCardListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AllowedCardListLocalDataManagerInputProtocol? { get set }
    
    func fetchCardList()
    func cardSelected(cards: [CardConfiguration])
    func shouldGoBack(animated: Bool) -> Bool
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol AllowedCardListDataManagerInputProtocol: class{
}
/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol AllowedCardListAPIDataManagerInputProtocol: class{
}
/// Method contract between communication INTERACTOR -> LOCALDATAMANAGER
protocol AllowedCardListLocalDataManagerInputProtocol: class{
}
