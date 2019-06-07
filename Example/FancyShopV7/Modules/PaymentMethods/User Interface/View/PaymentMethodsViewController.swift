//
//  PaymentMethodsView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
import MCSCommerceWeb

typealias CompletionBlock = () -> Void

/// Shows the payment methods, if massterpass is selected goes to the pairing mode
class PaymentMethodsViewController: BaseViewController, PaymentMethodsViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    /// Variables
    var presenter: PaymentMethodsPresenterProtocol?
    fileprivate var paymentMethods: [NSDictionary]?
    fileprivate let reuseIdentifier = "PaymentMethodsTableViewCell"
    fileprivate var userHasPairingId: Bool = false
    fileprivate var userHasPairingTransactionId: Bool = false
    @IBOutlet weak var paymentMethodsTableView: UITableView!
    var finalCallback: CompletionBlock?
    /// Static method will initialize the view
    ///
    /// - Returns: PaymentMethodsViewController instance to be presented
    static func instantiate() -> PaymentMethodsViewController{
        return UIStoryboard(name: "PaymentMethods", bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodsViewController") as! PaymentMethodsViewController
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchPaymentMethods()
    }
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.checkIfPairingShouldBeShown()
    }
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.finalCallback?()
        }
    }
    
    @IBAction func deletePaymentMethodAction(_ sender: Any) {
        PaymentMethod.sharedInstance.removePaymentMethod()
        self.paymentMethodsTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PaymentMethodsTableViewCell
        let name:String = self.paymentMethods![indexPath.row].value(forKey: "name") as! String
        cell.paymentMethodImage.image = UIImage(named:self.paymentMethods![indexPath.row].value(forKey: "image") as! String)
        cell.paymentMethodNameLabel.text = name
        cell.accessoryType  = .none
        //if name == Constants.paymentMethods.masterpass && (self.userHasPairingId || self.userHasPairingTransactionId)
        if name == Constants.paymentMethods.masterpass {
            if let paymentMethodObject = PaymentMethod.sharedInstance.paymentMethodObject {
                cell.paymentMethodLastFourDigits.text = paymentMethodObject.paymentMethodLastFourDigits
                cell.accessoryType  = .checkmark
                cell.paymentMethodDeleteBtn.isEnabled = true
                cell.paymentMethodDeleteBtn.alpha = 1.0
            }
            else {
                cell.paymentMethodLastFourDigits.text = ""
                cell.accessoryType = .none
                cell.paymentMethodDeleteBtn.isEnabled = false
                cell.paymentMethodDeleteBtn.alpha = 0.0
            }
        }
        else {
            cell.paymentMethodDeleteBtn.isEnabled = false
            cell.paymentMethodDeleteBtn.alpha = 0.0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name:String = self.paymentMethods![indexPath.row].value(forKey: "name") as! String
        self.presenter?.paymentMethodSelected(method: name)
        tableView.reloadData()
    }
    // MARK: PaymentMethodsViewProtocol
    
    /// Sets the payment methods to be shown
    ///
    /// - Parameter paymentMethods: NSDictionary array
    func setPaymentMethods(paymentMethods: [NSDictionary]){
        self.paymentMethods = paymentMethods
    }
    
    /// Sets the added payment method
    ///
    /// - Parameter paymentMethods: NSDictionary array
    func setAddedPaymentMethod(paymentMethod: PaymentMethod){
        
        DispatchQueue.main.async {
            self.paymentMethodsTableView.reloadData()
        }
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter error: String with the error
    func showError(error: String) {
        super.showErrorInAlert(message: error, title: "Error")
    }
    
    /// Saves the user hasPairingId flag and reloads the table
    ///
    /// - Parameter hasPairingId:  hasPairingId boolean flag
    func setUser(hasPairingId: Bool) {
        self.userHasPairingId = hasPairingId
        self.paymentMethodsTableView.reloadData()
    }
    
    /// Saves the user hasTransactionPairingId flag and reloads the table
    ///
    /// - Parameter hasTransactionPairingId:  hasTransactionPairingId boolean flag
    func setUser(hasTransactionPairingId: Bool) {
        self.userHasPairingTransactionId = hasTransactionPairingId
        self.paymentMethodsTableView.reloadData()
    }
    
}
