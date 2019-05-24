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
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class LanguageListPresenter: LanguageListPresenterProtocol, LanguageListInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: LanguageListViewProtocol?
    var interactor: LanguageListInteractorInputProtocol?
    var wireFrame: LanguageListWireFrameProtocol?
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    //MARK: LanguageListPresenterProtocol
    
    /// Ask for the current language
    func getCurrentLanguage() {
        self.interactor?.getCurrentLanguage()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        self.wireFrame?.goBack(animated)
    }
    
    /// Tells the interactor that a language has been selected
    ///
    /// - Parameter currency: Enum with the language
    func languageSelected(language: LanguageConfiguration) {
        self.interactor?.languageSelected(language: language)
    }
    
    /// Ask the interactor to fetch the language list
    func fetchLanguageList() {
        self.interactor?.fetchLanguageList()
    }
    
    //MARK: LanguageListInteractorOutputProtocol
    
    /// Sets the current language to the view
    ///
    /// - Parameter language: Enum with the current language
    func setCurrent(language: LanguageConfiguration) {
        self.view?.setCurrent(language: language)
    }

    /// Called after the language list are fetched from the server
    ///
    /// - Parameter languages: languages array
    func languagesFetched(languageList: [LanguageConfiguration]) {
        self.view?.showLanguageList(languageList: languageList)
    }
}
