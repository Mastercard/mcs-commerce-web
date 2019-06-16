//
//  SettingsCheckViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/17/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Settings view cell with a `switch`, used in the settings list
class SettingsCheckViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var isEnable: Bool = true {
        didSet {
            self.title.textColor = isEnable ? UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0) : UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0)
        }
    }
}
