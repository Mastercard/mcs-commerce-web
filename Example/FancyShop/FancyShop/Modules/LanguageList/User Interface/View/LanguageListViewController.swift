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
import UIKit
/// Shows the Language list
class LanguageListViewController: BaseViewController, LanguageListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    
    /// Mark Variables
    var presenter: LanguageListPresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    fileprivate let reuseIdentifier = "LanguageTableViewCell"
    fileprivate var languagesArray: [LanguageConfiguration] = []
    var selectedLanguage: LanguageConfiguration!
    @IBOutlet weak var backButton: UIButton!
    
    /// Static method will initialize the view
    ///
    /// - Returns: LanguageListViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "LanguageList", bundle: nil).instantiateViewController(withIdentifier: "LanguageListViewController") as! LanguageListViewController
    }
    
    /// Overwritten method from UIVIewController,perform required action on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsTableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchLanguageList()
        self.presenter?.getCurrentLanguage()
        self.enableAccessibility()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.languageListScreenStruct.backButton_Identifier
    }
    
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LanguageTableViewCell
        cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.unselect))
        let theLanguage: LanguageConfiguration = self.languagesArray[indexPath.row]
        if theLanguage.language == self.selectedLanguage.language {
            cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.select))
        }
        cell.languageName.text = theLanguage.language
        cell.accessibilityIdentifier = objectLocator.languageListScreenStruct.language_Identifier + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLanguage = self.languagesArray[indexPath.row]
        self.presenter?.languageSelected(language: self.selectedLanguage)
        tableView.reloadData()
    }
    
    // MARK: LanguageListViewProtocol
    
    /// Seets the current language and show it in the view
    ///
    /// - Parameter language: Selected language
    func setCurrent(language: LanguageConfiguration) {
        self.selectedLanguage = language
    }
    
    /// Stores the language list and reloads the table view
    ///
    /// - Parameter languageList: languages array
    func showLanguageList(languageList: [LanguageConfiguration]) {
        self.languagesArray = languageList
    }
    
    
}
