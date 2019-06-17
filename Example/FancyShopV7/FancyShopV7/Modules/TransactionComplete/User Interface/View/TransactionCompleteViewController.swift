//
//  TransactionCompleteView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
import MCSCommerceWeb

/// Shows the view that confirm that the purchase has been done
class TransactionCompleteViewController: BaseViewController, TransactionCompleteViewProtocol, UITableViewDataSource, UITableViewDelegate{
    
    
    // MARK: Variables
    var presenter: TransactionCompletePresenterProtocol?
    var masterPassButton : MCCMasterpassButton?;
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
    fileprivate var items: [ShoppingCartItem] = []
    fileprivate let reuseIdentifier = "completeCartItemCell"
    fileprivate let minimunHeight:Int = 497
    fileprivate let minimunTablewViewHeight:Int = 60
    
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
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        self.set(shippingStatus: true)
        super.viewWillAppear(animated)
        self.presenter?.fetchItemsFromShoppingCart()
        self.presenter?.getPaymentData()
        self.presenter?.orderConfirmed()
    }
    
    /// Reloads the data into all widgets
    override func reloadData() {
        self.itemsTableView.reloadData()
        self.calculateHeight()
        
    }
    
    /// Calculates the height and adjust the constraints as needed
    fileprivate func  calculateHeight(){
        self.tableViewHeight.constant = CGFloat(self.minimunTablewViewHeight * self.items.count)
        self.contentViewHeight.constant = CGFloat(CGFloat(self.minimunHeight) + self.tableViewHeight.constant)
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
    
    /// Sets the number of items in the button
    ///
    /// - Parameter quantity: number of products in the cart
    func showQuantityOfProductsInCartButton(quantity: Int) {
        self.shoppingCartButton.setBadgeText(numberOfItems: quantity)
    }
    
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
        self.orderNumber.text = orderNumber
    }
    
    /// Sets the suppress shipping flag and adjust the view according to it
    ///
    /// - Parameter taxes: suppress shipping flag
    func set(shippingStatus: Bool) {
        UIView.animate(withDuration: 1, animations: {
            self.shippingView.isHidden = shippingStatus
            if shippingStatus {
                self.shippingViewHeightConstraint.constant = 0
            }else{
                self.shippingViewHeightConstraint.constant = 160
            }
        }, completion: nil)
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
        cell.itemQuantity.text = String(shoppingCartItem.quantity) + "x"
        cell.itemTotal.text = SDKConfiguration.sharedInstance.getCurrencySymbol() + String(theProduct.salePrice * Double(shoppingCartItem.quantity))
        return cell
    }
}
