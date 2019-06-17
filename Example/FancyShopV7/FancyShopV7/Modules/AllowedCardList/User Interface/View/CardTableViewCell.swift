//
//  CardTableViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Cell used in the AllowedCardListViewController table
class CardTableViewCell: UITableViewCell {
    // Variables
    /// Card Image
    @IBOutlet weak var cardImageView: UIImageView!
    
    /// Card Name
    @IBOutlet weak var cardNameLabel: UILabel!
}
