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

/// View that is presented to see the order details and confirm the order
class ConfirmOrderViewController: BaseViewController, ConfirmOrderViewProtocol, UITableViewDataSource, UITableViewDelegate{
    
    
    
    /// MARK: Variables
    var presenter: ConfirmOrderPresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var shoppingCartButton: ShoppingCartButton!
    @IBOutlet weak var taxesLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shippingAddressLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var shippingView: UIView!
    @IBOutlet weak var shippingViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    fileprivate var items: [ShoppingCartItem] = []
    fileprivate let reuseIdentifier = "confirmCartItemCell"
    fileprivate let minimunHeight:Int = 497
    fileprivate let minimunTablewViewHeight:Int = 60
    
    /// Static method will initialize the view
    ///
    /// - Returns: ConfirmOrderViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "ConfirmOrder", bundle: nil).instantiateViewController(withIdentifier: "ConfirmOrderViewController") as! ConfirmOrderViewController
    }
    /// Overwritten method from UIVIewController, sets the constraints for the required views
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftConstraint = NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(leftConstraint);
        let rightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(rightConstraint);
        self.enableAccessibility()
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //startAnimating()
        self.presenter?.fetchItemsFromShoppingCart()
        self.presenter?.getPaymentData()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.shoppingCartButton?.accessibilityIdentifier     = objectLocator.confirmOrderScreenStruct.btnshoppingCart_Identifier
        self.confirmButton?.accessibilityIdentifier = objectLocator.confirmOrderScreenStruct.btnConfirm_Identifier
        self.cancelButton?.accessibilityIdentifier = objectLocator.confirmOrderScreenStruct.btnCancel_Identifier
        self.backButton?.accessibilityIdentifier = objectLocator.confirmOrderScreenStruct.backButton_Identifier
    }
    
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBackToProductList(animated: true)
    }
    
    /// Sets the number of items in the cart button
    ///
    /// - Parameter quantity: number of items
    func showQuantityOfProductsInCartButton(quantity: Int) {
        self.shoppingCartButton.setBadgeText(numberOfItems: quantity)
    }
    
    /// Called to reload the data in the widgets
    override func reloadData() {
        self.itemsTableView.reloadData()
        self.calculateHeight()
        
    }
    
    /// Calculates the height of the content and apply it to the view
    fileprivate func  calculateHeight(){
        self.tableViewHeight.constant = CGFloat(self.minimunTablewViewHeight * self.items.count)
        self.contentViewHeight.constant = CGFloat(CGFloat(self.minimunHeight) + self.tableViewHeight.constant)
        self.view.layoutIfNeeded()
    }
    
    /// Return the item at that index
    ///
    /// - Parameter index: Index to get the item
    /// - Returns: ShoppingCartItem instance
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
    
    /// Confirms the order, calls the presenter to do it
    ///
    /// - Parameter sender: Any object
    @IBAction func confirmOrderAction(_ sender: Any) {
        
        ShoppingCart.sharedInstance.emptyCart()
        self.presenter?.goBackToProductList(animated: true)
        //startAnimating()
        //self.presenter?.confirmOrderAction()
    }
    // MARK: ConfirmOrderViewProtocol
    
    /// Gets the ShoppingCartItem's and display them
    ///
    /// - Parameter items: ShoppingCartItem array
    func showItemsInCart(items: [ShoppingCartItem]) {
        self.items = items
        self.reloadData()
    }
    
    /// Shows an error
    ///
    /// - Parameter message: String with the error
    func showError(message: String) {
        stopAnimating()
        super.showErrorInAlert(message: message, title: "", handler:{(alert: UIAlertAction!) in self.presenter?.goBackToProductList(animated: true)})
    }
    
    /// Set the taxes
    ///
    /// - Parameter taxes: Taxes
    func set(taxes: String) {
        self.taxesLabel.text = taxes
    }
    
    /// Set the subtotal
    ///
    /// - Parameter subtotal: Subtotal
    func set(subtotal: String) {
        self.subtotalLabel.text = subtotal
    }
    
    /// Set the total
    ///
    /// - Parameter total: Total
    func set(total: String) {
        self.totalLabel.text = total
    }
    
    /// Sets the shipping address
    ///
    /// - Parameter shippingAddress: String with the shipping address
    func set(shippingAddress: String) {
        self.shippingAddressLabel.text = shippingAddress
    }
    
    /// Sets the card number
    ///
    /// - Parameter cardNumber:
    func set(cardNumber: String) {
        self.cardNumberLabel.text = cardNumber
    }
    
    /// Called when the payment data is found
    func gotPaymentData() {
        stopAnimating()
    }
    
    /// Sets the order number
    ///
    /// - Parameter orderNumber: String with the order number
    func set(orderNumber: String) {
        self.orderNumber.text = orderNumber
    }
    
    /// Called when the postback is done
    func postbackDone() {
        stopAnimating()
    }
    
    /// Sets the shipping status and hides the view if it is necessary
    ///
    /// - Parameter shippingStatus: Shipping status flag
    func set(shippingStatus: Bool) {
        UIView.animate(withDuration: 1, animations: {
            self.shippingView.isHidden = shippingStatus
            if shippingStatus {
                self.shippingViewHeightConstraint.constant = 0
            }else{
                self.shippingViewHeightConstraint.constant = 160
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConfirmOrderItemViewCell
        let shoppingCartItem: ShoppingCartItem = self.getShoppingCartItemFromListUsingIndex(index: indexPath.row)
        let theProduct: Product = shoppingCartItem.product
        cell.itemName.text = theProduct.name
        cell.itemQuantity.text = String(shoppingCartItem.quantity) + "x"
        cell.itemTotal.text = "$" + String(theProduct.salePrice * Double(shoppingCartItem.quantity))
        return cell
    }
}
