/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

import Foundation

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
