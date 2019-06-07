//
//  AllowedDSRPListView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

class AllowedDSRPListViewController: BaseViewController, AllowedDSRPListViewProtocol, UITableViewDataSource, UITableViewDelegate {
    var presenter: AllowedDSRPListPresenterProtocol?
    fileprivate var dsrpsArray: [DSRP]?
    fileprivate let reuseIdentifier = "DSRPTableViewCell"
    fileprivate var tableView: UITableView?
    
    static func instantiate() -> AllowedDSRPListViewController{
        return UIStoryboard(name: "AllowedDSRPList", bundle: nil).instantiateViewController(withIdentifier: "AllowedDSRPListViewController") as! AllowedDSRPListViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.fetchDSRPList()
    }
    @IBAction func goBackAction(_ sender: Any) {
        self.presenter?.goBack(animated: true)
    }
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
        return (self.dsrpsArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DSRPTableViewCell
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        let dsrp: DSRP = (self.dsrpsArray?[indexPath.row])!
        if dsrp.isSelected{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        cell.dsrpNameLabel.text = dsrp.name.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dsrpSelected: DSRP = self.dsrpsArray![indexPath.row]
        dsrpSelected.isSelected = !dsrpSelected.isSelected
        self.presenter?.dsrpSelectedAction(dsrps: self.dsrpsArray!)
        tableView.reloadData()
    }
    // MARK: AllowedDSRPListViewProtocol
    func setDSRPList(dsrps: [DSRP]){
        self.dsrpsArray = dsrps
    }
    
}
