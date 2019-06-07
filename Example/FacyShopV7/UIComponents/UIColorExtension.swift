//
//  UIColorExtension.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/7/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension to use a couple of custom initializers
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
