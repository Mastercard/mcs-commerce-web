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

/// View that is presented to enable/disable cards used to configure the SDK
class AllowedCardListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// MARK: Variables
    fileprivate var cardsArray: [CardConfiguration] = []
    fileprivate let reuseIdentifier = "CardTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    /// Static method will initialize the view
    ///
    /// - Returns: AllowedCardListViewController instance to be presented
    static func instantiate() -> UIViewController {
        return UIStoryboard(name: "AllowedCardList", bundle: nil).instantiateViewController(withIdentifier: "AllowedCardListViewController") as! AllowedCardListViewController
    }
    
    /// Overwritten method from UIVIewController,perform required action on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    /// Overwritten method from UIVIewController, calls presenter to fetch the card list
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCardList()
        self.enableAccessibility()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        // Set Identifiers
        self.backButton?.accessibilityIdentifier = ObjectLocator.allowCardListScreenStruct.backButton_Identifier
    }
    
    /// View action, called to go back to the previous screen
    ///
    /// - Parameter sender: view that calls this action
    @IBAction func goBackAction(_ sender: Any) {
        NavigationHelper.sharedInstance.singleBack(animated: true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.cardsArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CardTableViewCell
        cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.unselect))
        
        let card: CardConfiguration = (self.cardsArray[indexPath.row])
        if card.isSelected{
            cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.select))
        }
        cell.cardNameLabel.text = card.name.rawValue
        cell.cardImageView.image = UIImage.init(named: card.image)
        cell.accessibilityIdentifier = ObjectLocator.allowCardListScreenStruct.cardBrand_Identifier + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardSelected: CardConfiguration = self.cardsArray[indexPath.row]
        cardSelected.isSelected = !cardSelected.isSelected
        self.cardSelectedAction(cards: self.cardsArray)
        tableView.reloadData()
    }
    
    /// Called from the presenter, it will store the cards in a local var
    ///
    /// - Parameter cards: cards array
    func fetchCardList() {
        self.cardsArray = SDKConfiguration.sharedInstance.cards
    }
    
    func cardSelectedAction(cards: [CardConfiguration]) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.cards = cards
        configuration.saveConfiguration()
    }
    
}
