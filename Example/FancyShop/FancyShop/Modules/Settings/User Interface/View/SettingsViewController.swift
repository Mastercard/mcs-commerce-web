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


fileprivate enum options:String {
    case Cards
    case Language
    case Currency
    case Shipping
    case SuppressShipping
    case EnableDSRPTransaction
    case SelectMethodCheckout
    static let allValues = [Cards, Language, Currency, SuppressShipping, Shipping, EnableDSRPTransaction, SelectMethodCheckout]
}

/// View controller that shows the available setting for the merchant app
class SettingsViewController: BaseViewController, SettingsViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Variables
    var presenter: SettingsPresenterProtocol?
    var cardReuseIdentifier: String = "SettingsCardViewCell"
    var textReuseIdentifier: String = "SettingsTextViewCell"
    var checkReuseIdentifier: String = "SettingsCheckViewCell"
    @IBOutlet weak var settingsTable: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var selectedCards: [CardConfiguration]?
    var selectedLanguage: LanguageConfiguration?
    var selectedCurrency: String?
    var suppressShippingStatus: Bool = false
    var isPaymentMethodCheckoutEnabled: Bool = false
    
    /// Static method will initialize the view
    ///
    /// - Returns: SettingsViewController instance to be presented
    static func instantiate() -> SettingsViewController{
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    }
    
    
    /// Overwritten method from UIVIewController,perform required action on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTable.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getSavedConfig()
        self.enableAccessibility()
    }
    // MARK: Methods
    // MARK: SettingsViewProtocol
    
    @IBAction func backAction(_ sender: Any) {
        self.presenter?.goBackToProductList(animated: true)
    }
    
    /// Sets Identifiers
    private func enableAccessibility() {
        /* NOTE: Accessibility Identifier are going to remain same irrespective of the localization. Hence not accessing it using .strings file. It will be performance overhead at runtime. */
        //Set Identifiers
        self.backButton?.accessibilityIdentifier     = objectLocator.SettingScreenStruct.backButton_Identifier
    }
    
    /// Shows a spinner in the view
    func startAnimating() {
        super.startAnimating()
    }
    
    /// Dimisses the spinner from the view
    func stopAnimating() {
        super.stopAnimating()
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter error: String with the error
    func showError(error: String) {
        super.showErrorInAlert(message: error, title: "")
    }
    
    /// Sets the saved data and show it
    ///
    /// - Parameters:
    ///   - cards: cards saved
    ///   - language: language saved
    ///   - currency: currecny saved
    ///   - shippingStatus: shipping status flag saved
    ///   - paymentMethodCheckoutStatus: paymentMethod checkout flag saved
    func setSavedData(cards: [CardConfiguration], language: LanguageConfiguration, currency: String, shippingStatus: Bool, paymentMethodCheckoutStatus: Bool){
        self.selectedCards = cards
        self.selectedLanguage = language
        self.selectedCurrency = currency
        self.suppressShippingStatus = shippingStatus
        self.isPaymentMethodCheckoutEnabled = paymentMethodCheckoutStatus
        self.settingsTable.reloadData()
    }
    // MARKK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options.allValues[indexPath.row]
        let cellCards: SettingsCardViewCell
        let cellText: SettingsTextViewCell
        let cellCheck: SettingsCheckViewCell
        
        switch option {
        case options.Cards:
            cellCards = tableView.dequeueReusableCell(withIdentifier: cardReuseIdentifier, for: indexPath) as! SettingsCardViewCell
            cellCards.setupCards(cards: self.selectedCards!)
            cellCards.accessibilityIdentifier = objectLocator.SettingScreenStruct.allowedCardType_Identifier
            return cellCards
        case options.Language:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "LANGUAGE"
            cellText.detail.text = self.selectedLanguage?.language
            cellText.accessibilityIdentifier = objectLocator.SettingScreenStruct.changeLanguage_Identifier
            return cellText
        case options.Currency:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "CURRENCY"
            cellText.detail.text = self.selectedCurrency
            cellText.accessibilityIdentifier = objectLocator.SettingScreenStruct.changeCurrency_Identifier
            return cellText
        case options.Shipping:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "SHIPPING OPTION"
            cellText.detail.text = "World Postal Service (WOPS)"
            cellText.accessibilityIdentifier = objectLocator.SettingScreenStruct.changeShipping_Identifier
            return cellText
        case options.SuppressShipping:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "SUPRESS SHIPPING"
            cellCheck.switch.setOn(self.suppressShippingStatus, animated: true)
            cellCheck.switch.accessibilityIdentifier = objectLocator.SettingScreenStruct.surpressShippingToggle_Identifier
            return cellCheck
        case options.EnableDSRPTransaction:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "TOKENIZATION"
            cellText.topViewConstraint.constant = 24
            cellText.detail.text = ""
            cellText.accessibilityIdentifier = objectLocator.SettingScreenStruct.changeTokenization_Identifier
            return cellText
        case options.SelectMethodCheckout:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "PAYMENT METHODS"
            cellText.topViewConstraint.constant = 24
            cellText.detail.text = ""
            cellText.accessibilityIdentifier = objectLocator.SettingScreenStruct.changePaymentMethod_Identifier
            return cellText
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.handleRowSelectedFrom(tableView, didSelectRowAt: indexPath)
    }
    fileprivate func handleRowSelectedFrom(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let option = options.allValues[indexPath.row]
        switch option {
        case options.Cards:
            self.cardsAllowedOptionSelected()
        case options.Language:
            self.languagesOptionSelected()
        case options.Currency:
            self.currenciesOptionSelected()
        case options.Shipping:
            return
        case options.SuppressShipping:
            self.suppressShippingOptionSelected()
        case options.EnableDSRPTransaction:
            self.DSRPAllowedOptionSelected()
        case .SelectMethodCheckout:
            self.selectPaymentMethod()
        }
    }
    
    // MARK: Option handlers
    fileprivate func cardsAllowedOptionSelected(){
        self.presenter?.gotToAllowedCardList()
    }
    fileprivate func languagesOptionSelected(){
        self.presenter?.goToLanguageList()
    }
    fileprivate func currenciesOptionSelected(){
        self.presenter?.gotToCurrencyList()
    }
    fileprivate func suppressShippingOptionSelected(){
        self.presenter?.suppressShippingAction()
    }
    fileprivate func DSRPAllowedOptionSelected(){
        self.presenter?.gotToAllowedDSRPList()
    }
    fileprivate func enablePaymentMethodCheckoutOptionSelected(){
        self.presenter?.togglePaymentMethodCheckoutOptionOnOff()
    }
    fileprivate func selectPaymentMethod() {
        self.presenter?.selectPaymentMethod()
    }
}
