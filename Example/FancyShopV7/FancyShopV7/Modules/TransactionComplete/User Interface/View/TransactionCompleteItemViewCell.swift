//
//  TransactionCompleteItemViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/26/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Table view cell used in the transaction complete list
class TransactionCompleteItemViewCell: UITableViewCell {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemTotal: UILabel!
}
