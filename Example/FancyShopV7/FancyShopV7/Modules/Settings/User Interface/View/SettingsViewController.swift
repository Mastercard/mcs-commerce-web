//
//  SettingsView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit


fileprivate enum options:String {
    case Cards
    case Language
    case Currency
    case Shipping
    case SuppressShipping
    case Suppress3DS
    case EnableExpressCheckout
    case EnablePairingWithCheckout
    case EnableDSRPTransaction
    case TogglePaymentMethodCheckout
    case SelectMethodCheckout
    case ParingOnly
    static let allValues = [Cards, Language, Currency, Shipping, SuppressShipping,Suppress3DS, EnableExpressCheckout,EnablePairingWithCheckout,ParingOnly,TogglePaymentMethodCheckout,SelectMethodCheckout]
}

/// View controller that shows the available setting for the merchant app
class SettingsViewController: BaseViewController, SettingsViewProtocol, UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK: Variables
    var presenter: SettingsPresenterProtocol?
    var cardReuseIdentifier: String = "SettingsCardViewCell"
    var textReuseIdentifier: String = "SettingsTextViewCell"
    var checkReuseIdentifier: String = "SettingsCheckViewCell"
    @IBOutlet weak var settingsTable: UITableView!
    var selectedCards: [CardConfiguration]?
    var selectedLanguage: String?
    var selectedCurrency: String?
    var suppressShippingStatus: Bool = false
    var suppress3DS: Bool = false
    var enableExpressCheckoutStatus: Bool = false
    var EnablePairingWithCheckoutStatus: Bool = false
    var isPaymentMethodCheckoutEnabled: Bool = false
    
    /// Static method will initialize the view
    ///
    /// - Returns: SettingsViewController instance to be presented
    static func instantiate() -> SettingsViewController{
        return UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getSavedConfig()
    }
    // MARK: Methods
    // MARK: SettingsViewProtocol
    
    @IBAction func backAction(_ sender: Any) {
        self.presenter?.goBackToProductList(animated: true)
    }
    
    /// Shows a spinner in the view
    func startAnimating() {
//        super.startAnimating()
    }
    
    /// Dimisses the spinner from the view
    func stopAnimating() {
//        super.stopAnimating()
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
    ///   - expressCheckoutStatus: express checkout flag saved
    ///   - paymentMethodCheckoutStatus: paymentMethod checkout flag saved
    func setSavedData(cards: [CardConfiguration], language: String, currency: String, shippingStatus: Bool,suppress3DSStatus:Bool, expressCheckoutStatus: Bool,webCheckoutStatus:Bool, paymentMethodCheckoutStatus: Bool){
        self.selectedCards = cards
        self.selectedLanguage = language
        self.selectedCurrency = currency
        self.suppressShippingStatus = shippingStatus
        self.suppress3DS = suppress3DSStatus
        self.enableExpressCheckoutStatus = expressCheckoutStatus
        self.EnablePairingWithCheckoutStatus = webCheckoutStatus
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
            return cellCards
        case options.Language:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "LANGUAGE"
            cellText.detail.text = self.selectedLanguage
            return cellText
        case options.Currency:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "CURRENCY"
            cellText.detail.text = self.selectedCurrency
            return cellText
        case options.Shipping:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "SHIPPING"
            cellText.detail.text = "World Postal Service (WOPS)"
            return cellText
        case options.SuppressShipping:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "SUPPRESS SHIPPING"
            cellCheck.switch.setOn(self.suppressShippingStatus, animated: true)
            return cellCheck
        case options.Suppress3DS:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "SUPPRESS 3DS"
            cellCheck.switch.setOn(self.suppress3DS, animated: true)
            return cellCheck
        case options.EnableExpressCheckout:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "ENABLE EXPRESS CHECKOUT"
            cellCheck.switch.setOn(self.enableExpressCheckoutStatus, animated: true)
            return cellCheck
        case options.EnablePairingWithCheckout:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "ENABLE WEB PAIRING WITH CHECKOUT"
            cellCheck.switch.setOn(self.EnablePairingWithCheckoutStatus, animated: true)
            cellCheck.isEnable = self.enableExpressCheckoutStatus
            return cellCheck
        case options.TogglePaymentMethodCheckout:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as! SettingsCheckViewCell
            cellCheck.title.text = "ENABLE PAYMENT METHOD"
            cellCheck.switch.setOn(self.isPaymentMethodCheckoutEnabled, animated: true)
            return cellCheck
        case options.EnableDSRPTransaction:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "TOKENIZATION"
            cellText.topViewConstraint.constant = 24
            cellText.detail.text = ""
            return cellText
        case options.SelectMethodCheckout:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "PAYMENT METHODS"
            cellText.topViewConstraint.constant = 24
            cellText.detail.text = ""
            cellText.isEnable = self.isPaymentMethodCheckoutEnabled
            return cellText
        case options.ParingOnly:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as! SettingsTextViewCell
            cellText.title.text = "WEB PAIRING"
            cellText.topViewConstraint.constant = 24
            cellText.detail.text = ""
            cellText.isEnable = self.enableExpressCheckoutStatus
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
            return
        case options.Shipping:
            return
        case options.SuppressShipping:
            self.suppressShippingOptionSelected()
        case options.Suppress3DS:
            self.suppress3DSOptionSelected()
        case options.EnableExpressCheckout:
            self.enableExpressCheckoutOptionSelected()
        case options.EnablePairingWithCheckout:
            if self.enableExpressCheckoutStatus {
                self.enalbeWebCheckoutOptionSelected()
            }
        case options.EnableDSRPTransaction:
            self.DSRPAllowedOptionSelected()
        case .TogglePaymentMethodCheckout:
            self.enablePaymentMethodCheckoutOptionSelected()
        case .SelectMethodCheckout:
            if self.isPaymentMethodCheckoutEnabled {
                self.selectPaymentMethod()
            }
        case .ParingOnly:
            if self.enableExpressCheckoutStatus {
                self.selectParingOnly()
            }
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
    fileprivate func suppress3DSOptionSelected(){
        self.presenter?.suppress3DSAction()
    }
    fileprivate func enableExpressCheckoutOptionSelected(){
        self.presenter?.enableExpressCheckoutAction()
    }
    fileprivate func enalbeWebCheckoutOptionSelected() {
        self.presenter?.enablePairingWithCheckoutAction()
    }
    fileprivate func DSRPAllowedOptionSelected(){
        self.presenter?.gotToAllowedDSRPList()
    }
    fileprivate func enablePaymentMethodCheckoutOptionSelected() {
        self.presenter?.togglePaymentMethodCheckoutOptionOnOff()
    }
    fileprivate func selectPaymentMethod() {
        self.presenter?.selectPaymentMethod()
    }
    fileprivate func selectParingOnly() {
        self.presenter?.selectParingOnlyMethod()
    }
}
