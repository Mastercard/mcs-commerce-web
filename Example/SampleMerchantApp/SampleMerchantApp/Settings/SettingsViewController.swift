//
//  SettingsViewController.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/16/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import UIKit
import Foundation
import MCSCommerceWeb

fileprivate enum options: String {
    case Cards
    case Language
    case Currency
    case SuppressShipping
    case EnableDSRPTransaction
    case Amount
    static let allValues = [Cards, Language, Currency, SuppressShipping, Amount, EnableDSRPTransaction]
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MCSCheckoutDelegate {
    
    
    // MARK: Variables
    var cardReuseIdentifier: String = "SettingsCardViewCell"
    var textReuseIdentifier: String = "SettingsTextViewCell"
    var checkReuseIdentifier: String = "SettingsCheckViewCell"
    var textFieldReuseIdentifier: String = "SettingsTextFieldViewCell"
    
    @IBOutlet weak var settingsTable: UITableView!
    @IBOutlet weak var buttonContainer: UIView!
    var selectedCards: [CardConfiguration]?
    var selectedLanguage: LanguageConfiguration?
    var selectedCurrency: String?
    var amount: NSDecimalNumber?
    var suppressShippingStatus: Bool = false
    var settingsCoordinator = SettingsCoordinator()
    var completionHandler: (([AnyHashable : Any]?, Error?) -> ())? = nil
    
    var cellCards: SettingsCardViewCell?
    var cellText: SettingsTextViewCell?
    var cellCheck: SettingsCheckViewCell?
    var cellTextField: SettingsTextFieldViewCell?
    
    /// Overwritten method from UIVIewController,perform required action on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardDissmissGesture()
        self.settingsTable.tableFooterView = UIView.init(frame: CGRect.zero)
        settingsCoordinator.manager.initalizeSDK()
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getSavedConfig()
        self.addCheckoutButtonToView()
    }
    
    /// Method to add tap gesture recognizer on the view to dismiss keybaord
    func addKeyboardDissmissGesture() {
        let dismissKeyboard = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        // Since there's a table view, add this to dismiss on touch of table view as well
        dismissKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboard)
    }
    
    /// Method to retrieve the checkoutButton and add it to a UIViewController
    func addCheckoutButtonToView() {
        if (self.buttonContainer.subviews.filter{$0 is MCSCheckoutButton}.isEmpty) {
            let checkoutButton = self.getCheckoutButton(completionHandler: { (response, error) in
                if let err = error {
                    let errorCode = "errorCode :\((err as NSError).code)"
                    let alert = UIAlertController(title:errorCode, message:err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    if let returnedResponse = response {
                        print("Returned Response \(returnedResponse)");
                    }
                }
            })
            
            checkoutButton.addToSuperview(superview: self.buttonContainer)
        }
    }
    
    /// Gets the saved data and show it
    ///
    /// - Parameters:
    ///   - cards: cards saved
    ///   - language: language saved
    ///   - currency: currecny saved
    ///   - shippingStatus: shipping status flag saved
    ///   - paymentMethodCheckoutStatus: paymentMethod checkout flag saved
    func getSavedConfig() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        self.selectedCards = configuration.cards
        self.selectedLanguage = configuration.language
        self.selectedCurrency = configuration.currency
        self.suppressShippingStatus = configuration.suppressShipping
        self.settingsTable.reloadData()
    }
    
    // MARKK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options.allValues[indexPath.row]
        
        switch option {
        case options.Cards:
            cellCards = tableView.dequeueReusableCell(withIdentifier: cardReuseIdentifier, for: indexPath) as? SettingsCardViewCell
            cellCards!.setupCards(cards: self.selectedCards!)
            cellCards!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.allowedCardType_Identifier
            return cellCards!
        case options.Language:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as? SettingsTextViewCell
            cellText!.title.text = "LANGUAGE"
            cellText!.detail.text = self.selectedLanguage?.language
            cellText!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.changeLanguage_Identifier
            return cellText!
        case options.Currency:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as? SettingsTextViewCell
            cellText!.title.text = "CURRENCY"
            cellText!.detail.text = self.selectedCurrency
            cellText!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.changeCurrency_Identifier
            return cellText!
        case options.SuppressShipping:
            cellCheck = tableView.dequeueReusableCell(withIdentifier: checkReuseIdentifier, for: indexPath) as? SettingsCheckViewCell
            cellCheck!.title.text = "SUPRESS SHIPPING"
            cellCheck!.switch.setOn(self.suppressShippingStatus, animated: true)
            cellCheck!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.surpressShippingToggle_Identifier
            return cellCheck!
        case options.Amount:
            cellTextField = tableView.dequeueReusableCell(withIdentifier: textFieldReuseIdentifier, for: indexPath) as? SettingsTextFieldViewCell
            cellTextField!.title.text = "AMOUNT"
            cellTextField!.amount.delegate = self
            cellTextField!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.amount_Identifier
            return cellTextField!
        case options.EnableDSRPTransaction:
            cellText = tableView.dequeueReusableCell(withIdentifier: textReuseIdentifier, for: indexPath) as? SettingsTextViewCell
            cellText!.title.text = "TOKENIZATION"
            cellText!.topViewConstraint.constant = 24
            cellText!.detail.text = ""
            cellText!.accessibilityIdentifier = ObjectLocator.SettingScreenStruct.changeTokenization_Identifier
            return cellText!
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
        case options.SuppressShipping:
            self.suppressShippingOptionSelected()
        case options.Amount:
            return
        case options.EnableDSRPTransaction:
            self.DSRPAllowedOptionSelected()
        }
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case ".":
            let array = Array(textField.text!)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }

            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string)
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    
    // MARK: Option handlers
    fileprivate func cardsAllowedOptionSelected() {
        self.settingsCoordinator.cardsAllowedOptionSelected()
    }
    
    fileprivate func languagesOptionSelected() {
        self.settingsCoordinator.languagesOptionSelected()
    }
    
    fileprivate func currenciesOptionSelected() {
        self.settingsCoordinator.currenciesOptionSelected()
    }
    
    fileprivate func suppressShippingOptionSelected() {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.suppressShipping = !configuration.suppressShipping
        configuration.saveConfiguration()
        self.getSavedConfig()
    }
    
    fileprivate func DSRPAllowedOptionSelected() {
        self.settingsCoordinator.DSRPAllowedOptionSelected()
    }
    
    func getCheckoutButton(completionHandler: @escaping ([AnyHashable : Any]?, Error?) -> ()) -> MCSCheckoutButton {
        self.completionHandler = completionHandler
        
        return SRCSDKManager.sharedInstance.getCheckoutButton(with: self)
    }
    
    // MARK: MCSCheckoutDelegate
    func getCheckoutRequest(withHandler handler: @escaping (MCSCheckoutRequest) -> Void) {
        
        if let amountText = Float(cellTextField!.amount.text!) {
            self.amount = NSDecimalNumber(string: String(format: "%.2f", amountText))
        }
        
        if (self.amount != nil) {
            handler(getCheckoutRequest())
        } else {
            self.showAlert(message: Constants.alertMessages.amount.amountMessage, title: Constants.alertMessages.amount.amountTitle, handler: nil)
        }
        
    }
    
    func checkoutCompleted(withRequest request: MCSCheckoutRequest, status: MCSCheckoutStatus, transactionId: String?) {
        completionHandler?(["TransactionId" : transactionId ?? ""], nil)
        var checkoutStatus = ""
        
        if (status == MCSCheckoutStatus.success) {
            checkoutStatus = "Success"
        } else {
            checkoutStatus = "Canceled"
        }
        
        self.showAlert(message: checkoutStatus, title: Constants.alertMessages.checkoutStatus.checkoutStatusTitle, handler: nil)
    }
    
    func getCheckoutRequest() -> MCSCheckoutRequest {
        let data: DataPersisterManager = DataPersisterManager.sharedInstance
        let sdkConfig : SDKConfiguration = SDKConfiguration.sharedInstance
        
        let checkoutRequest = MCSCheckoutRequest()
        checkoutRequest.amount = self.amount!
        checkoutRequest.currency = sdkConfig.currency
        checkoutRequest.cartId = data.getRandomCartId(length: 6)
        checkoutRequest.suppressShippingAddress = sdkConfig.suppressShipping
        checkoutRequest.unpredictableNumber = "12345678"
        
        let cryptoOptionMaster = MCSCryptoOptions()
        cryptoOptionMaster.cardType = "master"
        cryptoOptionMaster.format = ["ICC,UCAF"]
        
        checkoutRequest.cryptoOptions = [cryptoOptionMaster]
        
        return checkoutRequest
    }
    
    /// Shows an alert on top of the current view controller
    ///
    /// - Parameters:
    ///   - message: String with the message
    ///   - title: String with the title
    ///   - handler: Block of code to execute when the user clicks on a
    func showAlert(message: String = "", title: String = "", handler: ((UIAlertAction) -> Swift.Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

