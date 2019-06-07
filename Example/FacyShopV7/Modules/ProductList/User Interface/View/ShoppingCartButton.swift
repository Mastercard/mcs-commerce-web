//
//  ShoppingCartButton.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/8/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit
/// Custom buttom to be shown
class ShoppingCartButton: BadgedButton {
    
    /// Sets the number of products in the cart on the button
    ///
    /// - Parameter numberOfItems: Number of products
    func setBadgeText(numberOfItems: Int){
        self.setImage(UIImage(named: "cartButton"), for: .normal)
        self.badge.isHidden = true
        if(numberOfItems > 0){
            self.badge.isHidden = false
            self.setImage(UIImage(named: "cartWithProductsButton"), for: .normal)
            self.badge.text = String(numberOfItems)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setBadgeText(numberOfItems: 0)
        var frame = self.badge.frame
        frame.size.height = 18
        frame.size.width = 18
        self.badge.frame = frame
    }
}
