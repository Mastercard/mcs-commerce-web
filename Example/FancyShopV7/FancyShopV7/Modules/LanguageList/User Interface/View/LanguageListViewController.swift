//
//  LanguageListView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
/// Shows the Language list
class LanguageListViewController: BaseViewController, LanguageListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    
    /// Mark Variables
    var presenter: LanguageListPresenterProtocol?
    @IBOutlet weak var itemsTableView: UITableView!
    fileprivate let reuseIdentifier = "LanguageTableViewCell"
    fileprivate var languagesArray: [String] = Constants.languages.allValues
    var selectedLanguage: String!
    
    /// Static method will initialize the view
    ///
    /// - Returns: LanguageListViewController instance to be presented
    static func instantiate() -> Any{
        return UIStoryboard(name: "LanguageList", bundle: nil).instantiateViewController(withIdentifier: "LanguageListViewController") as! LanguageListViewController
    }
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getCurrentLanguage()
    }
    /// Ask the presenter to go back
    ///
    /// - Parameter sender: Any object
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LanguageTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        let theLanguage: String = self.languagesArray[indexPath.row]
        if theLanguage == self.selectedLanguage{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.languageName.text = theLanguage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLanguage = self.languagesArray[indexPath.row]
        self.presenter?.languageSelected(language: self.selectedLanguage)
        tableView.reloadData()
    }
    
    // MARK: LanguageListViewProtocol
    
    /// Seets the current language and show it in the view
    ///
    /// - Parameter language: Selected language
    func setCurrent(language: String) {
        self.selectedLanguage = language
    }
    
    
    
}
