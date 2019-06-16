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

class AllowedDSRPListViewController: BaseViewController, AllowedDSRPListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    var presenter: AllowedDSRPListPresenterProtocol?
    fileprivate var dsrpsArray: [DSRP]?
    fileprivate let reuseIdentifier = "DSRPTableViewCell"
    fileprivate var tableView: UITableView?
    @IBOutlet weak var backButton: UIButton!
    
    
    static func instantiate() -> AllowedDSRPListViewController{
        return UIStoryboard(name: "AllowedDSRPList", bundle: nil).instantiateViewController(withIdentifier: "AllowedDSRPListViewController") as! AllowedDSRPListViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchDSRPList()
        self.enableAccessibility()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.allowDSRPListScreenStruct.backButton_Identifier
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(animated: true)
    }
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
        return (self.dsrpsArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DSRPTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        let dsrp: DSRP = (self.dsrpsArray?[indexPath.row])!
        if dsrp.isSelected{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.dsrpNameLabel.text = dsrp.name.rawValue
        cell.accessibilityIdentifier = objectLocator.allowDSRPListScreenStruct.DSRP_Identifier + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dsrpSelected: DSRP = self.dsrpsArray![indexPath.row]
        dsrpSelected.isSelected = !dsrpSelected.isSelected
        self.presenter?.dsrpSelectedAction(dsrps: self.dsrpsArray!)
        tableView.reloadData()
    }
    // MARK: AllowedDSRPListViewProtocol
    func setDSRPList(dsrps: [DSRP]){
        self.dsrpsArray = dsrps
    }
    
}
