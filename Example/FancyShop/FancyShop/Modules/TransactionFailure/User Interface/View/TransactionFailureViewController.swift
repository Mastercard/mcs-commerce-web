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

/// Shows the view that confirm that the purchase has been done
class TransactionFailureViewController: BaseViewController, TransactionFailureViewProtocol {
    var presenter: TransactionFailurePresenterProtocol?
    @IBOutlet weak var shoppingCartButton: ShoppingCartButton!
    @IBOutlet weak var retryCheckoutButton: UIButton!

    
    /// Overwritten method from UIVIewController, sets the constraints for the required views
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requestShoppingItemsConfigurationHandler()
    }
    
    /// Overwritten method from UIVIewController, sets the constraints for the required views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableAccessibility()
    }
    
    /// Static method will initialize the view
    ///
    /// - Returns: TransactionFailureViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "TransactionFailure", bundle: nil).instantiateViewController(withIdentifier: "TransactionFailureViewController") as! TransactionFailureViewController
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.shoppingCartButton.accessibilityIdentifier = objectLocator.transactionFailureStruct.btnCart_Identifier
        self.retryCheckoutButton.accessibilityIdentifier = objectLocator.transactionFailureStruct.btnRetryCheckout_Identifier
      
    }
    
    /// Sets the number of products on the cart
    ///
    /// - Parameter quantity: number of products
    func showQuantityOfProductsInCartButton(quantity: Int) {
        self.shoppingCartButton.setBadgeText(numberOfItems: quantity)
    }
    
    /// Ask the presenter to go to the order summary module
    ///
    /// - Parameter sender: Any object
    @IBAction func goToShoppingCartAction(_ sender: Any) {
        self.presenter?.goBackToOrderSummery(animated: true)
    }
    
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func retryCheckoutAction(_ sender: Any) {
        self.presenter?.goBackToOrderSummery(animated: true)
    }
}
