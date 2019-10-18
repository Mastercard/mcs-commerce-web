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


typealias CompletionBlock = () -> Void

/// Shows the payment methods, if massterpass is selected goes to the pairing mode
class PaymentMethodsViewController: BaseViewController, PaymentMethodsViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    /// Variables
    var presenter: PaymentMethodsPresenterProtocol?
    fileprivate var paymentMethods: [NSDictionary] = []
    fileprivate let reuseIdentifier = "PaymentMethodsTableViewCell"
    @IBOutlet weak var paymentMethodsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var finalCallback: CompletionBlock?

    /// Static method will initialize the view
    ///
    /// - Returns: PaymentMethodsViewController instance to be presented
    static func instantiate() -> PaymentMethodsViewController{
        return UIStoryboard(name: "PaymentMethods", bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodsViewController") as! PaymentMethodsViewController
    }
    
    /// Overwritten method from UIVIewController,perform required action on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.paymentMethodsTableView.tableFooterView = UIView.init(frame: CGRect.zero)
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
        self.enableAccessibility()
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.paymentMethodsListScreenStruct.backButton_Identifier
    }
    
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(animated: true)
    }
    
    @IBAction func deletePaymentMethodAction(_ sender: Any) {
        PaymentMethod.sharedInstance.removePaymentMethod()
        self.paymentMethodsTableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PaymentMethodsTableViewCell
        let name:String = self.paymentMethods[indexPath.row].value(forKey: "name") as! String
        cell.paymentMethodImage.image = UIImage(named:self.paymentMethods[indexPath.row].value(forKey: "image") as! String)
        cell.paymentMethodNameLabel.text = name
        cell.accessoryType  = .none
        if name == Constants.paymentMethods.masterpass {
            cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.unselect))
            if PaymentMethod.sharedInstance.paymentMethodObject != nil {
               cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.select))
            }
        }
        else if name == Constants.paymentMethods.paypal ||  name == Constants.paymentMethods.SRCMark {
                cell.paymentMethodLastFourDigits.text = ""
                cell.accessoryView = UIImageView(image: UIImage(named: Constants.images.disableSelect))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name:String = self.paymentMethods[indexPath.row].value(forKey: "name") as! String
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
        super.showErrorInAlert(message: error, title: Constants.error.kErrorTitle)
    }
    
}
