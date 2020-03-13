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

/// Shows the environment list
class EnvironmentListViewController: BaseViewController, EnvironmentListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    
    /// MARK: Variables
    var presenter: EnvironmentListPresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    fileprivate let reuseIdentifier = "EnvironmentTableViewCell"
    fileprivate var environmentsArray: [Constants.envEnum] = Constants.envEnum.allValues
    var selectedEnvironment: Constants.envEnum!
    @IBOutlet weak var backButton: UIButton!
    
    /// Static method will initialize the view
    ///
    /// - Returns: EnvironmentListViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "EnvironmentList", bundle: nil).instantiateViewController(withIdentifier: "EnvironmentListViewController") as! EnvironmentListViewController
    }
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getCurrentEnvironment()
        self.enableAccessibility()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.environmentListScreenStruct.backButton_Identifier
    }
    
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.environmentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EnvironmentTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        let theEnvironment: String = self.environmentsArray[indexPath.row].rawValue
        if theEnvironment == self.selectedEnvironment.rawValue{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.environmentName.text = theEnvironment
        cell.accessibilityIdentifier = objectLocator.environmentListScreenStruct.environment_Identifier + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEnvironment = Constants.envEnum(rawValue: self.environmentsArray[indexPath.row].rawValue)
        self.presenter?.environmentSelected(environment: self.selectedEnvironment)
        tableView.reloadData()
    }
    
    // MARK: EnvironmentListViewProtocol
    
    /// Sets the current environment and show it
    ///
    /// - Parameter environment: String with the environment
    func setCurrent(environment: Constants.envEnum) {
        self.selectedEnvironment = environment
    }
    
    
    
}

