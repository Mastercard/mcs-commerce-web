//
//  ItemViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/9/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Cell used in the summary list
class ItemViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productSalePrice: UILabel!
    
}
