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


/// Shows the view that confirm that the purchase has been done
class TransactionCompleteViewController: BaseViewController, TransactionCompleteViewProtocol, UITableViewDataSource, UITableViewDelegate{

    
    // MARK: Variables
    var presenter: TransactionCompletePresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var taxesLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var continueShoppingButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    fileprivate var items: [ShoppingCartItem] = []
    fileprivate let reuseIdentifier = "completeCartItemCell"
    fileprivate let minimunHeight:Int = 350
    fileprivate let minimunTablewViewHeight:Int = 50
    fileprivate let tablewViewHeaderHeight:Int = 30
    
    /// Static method will initialize the view
    ///
    /// - Returns: TransactionCompleteViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "TransactionComplete", bundle: nil).instantiateViewController(withIdentifier: "TransactionCompleteViewController") as! TransactionCompleteViewController
    }
    
    /// Overwritten method from UIViewcontroller, sets the corresponding constraints to the view
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftConstraint = NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(leftConstraint);
        let rightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(rightConstraint);
        self.setTableviewProperty()
        
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchItemsFromShoppingCart()
        self.presenter?.getPaymentData()
        self.presenter?.orderConfirmed()
        self.enableAccessibility()
    }
    
    /// Sets tableview dynamic property
    func setTableviewProperty() {
        self.itemsTableView.rowHeight = UITableView.automaticDimension;
        self.itemsTableView.estimatedRowHeight = CGFloat(minimunTablewViewHeight);
        self.itemsTableView.isUserInteractionEnabled = false
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.transectionCompleteScreenStruct.backButton_Identifier
        self.continueShoppingButton?.accessibilityIdentifier = objectLocator.transectionCompleteScreenStruct.btnContinuShopping_Identifier
    }
    
    /// Reloads the data into all widgets
    override func reloadData() {
        self.itemsTableView.reloadData()
        self.calculateHeight()
        
    }
    
    /// Calculates the height and adjust the constraints as needed
    fileprivate func  calculateHeight(){
        self.tableViewHeightConstraint.constant = CGFloat(self.minimunTablewViewHeight * self.items.count) + CGFloat(self.tablewViewHeaderHeight)
        self.contentViewHeight.constant = CGFloat(CGFloat(self.minimunHeight) + self.tableViewHeightConstraint.constant)
        self.view.layoutIfNeeded()
    }
    
    /// Ask the presenter to go back to the previous screen
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBackToProductList(animated: true)
    }
    
    /// Returns the item at the given index
    ///
    /// - Parameter index: Index to get the item
    /// - Returns: ShoppingCartItem object
    fileprivate func getShoppingCartItemFromListUsingIndex(index: Int) -> ShoppingCartItem{
        return self.items[index]
    }
    /// Returns the index for a selected button
    ///
    /// - Parameters:
    ///   - sender: UIButton
    ///   - levels: levels to search
    /// - Returns: int with the index
    fileprivate func getIndexPathFromCellUsingButton(_ sender: UIButton, _ levels: Int) -> Int{
        var i = 0
        var superview: UIView = sender.superview!
        while i < levels-1 {
            superview = superview.superview!
            i += 1
        }
        let cell: ItemViewCell = superview as! ItemViewCell
        if let indexPath: NSIndexPath = self.itemsTableView.indexPath(for: cell) as NSIndexPath? {
            return indexPath.row
        }
        return -1;
    }
    
    // MARK: TransactionCompleteViewProtocol
    
    /// Stores and reloads the table to show the items
    ///
    /// - Parameter items: Items in the shopping cart
    func showItemsInCart(items: [ShoppingCartItem]) {
        self.items = items
        self.reloadData()
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter message: String with the error
    func showError(message: String) {
        super.showErrorInAlert(message: message, title: "")
    }
    
    /// Sets and shows the taxes
    ///
    /// - Parameter taxes: taxes value
    func set(taxes: String) {
        self.taxesLabel.text = taxes
    }
    
    /// Sets and shows the subtotal
    ///
    /// - Parameter taxes: subtotal value
    func set(subtotal: String) {
        self.subtotalLabel.text = subtotal
    }
    
    /// Sets and shows the total
    ///
    /// - Parameter taxes: total value
    func set(total: String) {
        self.totalLabel.text = total
    }
    
    /// Sets and shows the shippingAddress
    ///
    /// - Parameter taxes: shippingAddress value
    func set(shippingAddress: String) {
        self.shippingAddressLabel.text = shippingAddress
    }
    
    /// Sets and shows the cardNumber
    ///
    /// - Parameter taxes: cardNumber value
    func set(cardNumber: String) {
        self.cardNumberLabel.text = cardNumber
    }
    
    /// Sets and shows the orderNumber
    ///
    /// - Parameter taxes: orderNumber value
    func set(orderNumber: String) {
        //self.orderNumber.text = orderNumber
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TransactionCompleteItemViewCell
        let shoppingCartItem: ShoppingCartItem = self.getShoppingCartItemFromListUsingIndex(index: indexPath.row)
        let theProduct: Product = shoppingCartItem.product
        cell.itemName.text = theProduct.name
        cell.itemOrder.text = String("(\(indexPath.row + 1))")
        cell.itemTotal.text = SDKConfiguration.sharedInstance.language.currencySymbol + String(format: "%.02f", theProduct.salePrice * Double(shoppingCartItem.quantity))
        cell.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableHeaderView
    }
}
