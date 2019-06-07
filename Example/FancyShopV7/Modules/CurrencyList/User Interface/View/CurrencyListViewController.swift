//
//  CurrencyListView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Shows the currency list
class CurrencyListViewController: BaseViewController, CurrencyListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    
    /// MARK: Variables
    var presenter: CurrencyListPresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    fileprivate let reuseIdentifier = "CurrencyTableViewCell"
    fileprivate var currencysArray: [String] = Constants.currencies.allValues
    var selectedCurrency: String!
    
    /// Static method will initialize the view
    ///
    /// - Returns: CurrencyListViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "CurrencyList", bundle: nil).instantiateViewController(withIdentifier: "CurrencyListViewController") as! CurrencyListViewController
    }
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getCurrentCurrency()
    }
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CurrencyTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        let theCurrency: String = self.currencysArray[indexPath.row]
        if theCurrency == self.selectedCurrency{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.currencyName.text = theCurrency
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCurrency = self.currencysArray[indexPath.row]
        self.presenter?.currencySelected(currency: self.selectedCurrency)
        tableView.reloadData()
    }
    
    // MARK: CurrencyListViewProtocol
    
    /// Sets the current currency and show it
    ///
    /// - Parameter currency: String with the currency
    func setCurrent(currency: String) {
        self.selectedCurrency = currency
    }
    
    
    
}
