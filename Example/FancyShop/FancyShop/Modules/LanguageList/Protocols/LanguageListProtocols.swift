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
protocol LanguageListViewProtocol: class {
    var presenter: LanguageListPresenterProtocol? { get set }
    func setCurrent(language: LanguageConfiguration)
    func showLanguageList(languageList: [LanguageConfiguration])
}

/// Method contract between PRESENTER -> WIREFRAME
protocol LanguageListWireFrameProtocol: class {
    static func presentLanguageListModule(fromView view: AnyObject)
    func goBack(_ animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol LanguageListPresenterProtocol: class {
    var view: LanguageListViewProtocol? { get set }
    var interactor: LanguageListInteractorInputProtocol? { get set }
    var wireFrame: LanguageListWireFrameProtocol? { get set }
    
    func getCurrentLanguage()
    func goBack(_ animated: Bool)
    func languageSelected(language: LanguageConfiguration)
    func fetchLanguageList()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol LanguageListInteractorOutputProtocol: class {
    func setCurrent(language: LanguageConfiguration)
    func languagesFetched(languageList: [LanguageConfiguration])
}

/// Method contract between PRESENTER -> INTERACTOR
protocol LanguageListInteractorInputProtocol: class
{
    var presenter: LanguageListInteractorOutputProtocol? { get set }
    var APIDataManager: LanguageListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: LanguageListLocalDataManagerInputProtocol? { get set }
    func getCurrentLanguage()
    func languageSelected(language: LanguageConfiguration)
    func fetchLanguageList()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol LanguageListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol LanguageListAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol LanguageListLocalDataManagerInputProtocol: class{
    func fetchLanguages(completionHandler: @escaping ([LanguageConfiguration]?, Error?) -> ())

}
