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

/// LanguageListInteractor implements LanguageListInteractorInputProtocol protocol, handles the interaction to save and change the tokenization values
class LanguageListInteractor: LanguageListInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: LanguageListInteractorOutputProtocol?
    var APIDataManager: LanguageListAPIDataManagerInputProtocol?
    var localDatamanager: LanguageListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    // MARK: LanguageListInteractorInputProtocol
    
    /// Gets the current language and pass it to the presenter
    func getCurrentLanguage() {
        let config: SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setCurrent(language: config.language)
    }
    
    /// Fetchs the language list and pass them to the presenter
    func fetchLanguageList() {
        self.localDatamanager?.fetchLanguages(completionHandler: { (languageList,error) in
            if languageList != nil {
                self.presenter?.languagesFetched(languageList: languageList!)
            }
        })
    }
    
    /// Saves the selected language in the configuration
    ///
    /// - Parameter language: Enum with the selected language
    func languageSelected(language: LanguageConfiguration) {
        SDKConfiguration.sharedInstance.setLanguage(language: language)
    }
}
