//
//  CardTableViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Payment method table view cell
class PaymentMethodsTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentMethodDeleteBtn: UIButton!
    @IBOutlet weak var paymentMethodLastFourDigits: UILabel!
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var paymentMethodNameLabel: UILabel!
}
