//
//  AllowedCardListView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// View that is presented to enable/disable cards used to configure the SDK
class AllowedCardListViewController: BaseViewController, AllowedCardListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    
    
    /// MARK: Variables
    var presenter: AllowedCardListPresenterProtocol?
    fileprivate var cardsArray: [CardConfiguration]?
    fileprivate let reuseIdentifier = "CardTableViewCell"
    fileprivate var tableView: UITableView?
    
    /// Static method will initialize the view
    ///
    /// - Returns: AllowedCardListViewController instance to be presented
    static func instantiate() -> AllowedCardListViewController{
        return UIStoryboard(name: "AllowedCardList", bundle: nil).instantiateViewController(withIdentifier: "AllowedCardListViewController") as! AllowedCardListViewController
    }
    
    /// Overwritten method from UIVIewController, calls presenter to fetch the card list
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchCardList()
    }
    
    /// View action, called to go back to the previous screen
    ///
    /// - Parameter sender: view that calls this action
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.shouldGoBack(animated: true)
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
        return (self.cardsArray?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CardTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        let card: CardConfiguration = (self.cardsArray?[indexPath.row])!
        if card.isSelected{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.cardNameLabel.text = card.name.rawValue
        cell.cardImageView.image = UIImage.init(named: card.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardSelected: CardConfiguration = self.cardsArray![indexPath.row]
        cardSelected.isSelected = !cardSelected.isSelected
        self.presenter?.cardSelectedAction(cards: self.cardsArray!)
        tableView.reloadData()
    }
    // MARK: AllowedCardListViewProtocol
    
    
    /// Called from the presenter, it will store the cards in a local var
    ///
    /// - Parameter cards: cards array
    func setCardList(cards: [CardConfiguration]){
        self.cardsArray = cards
    }
    
    /// Shows an error
    ///
    /// - Parameter error: error string
    func showError(error: String) {
        super.showErrorInAlert(message: error, title: "Error")
    }
    
}
