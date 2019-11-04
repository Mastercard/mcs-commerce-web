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

/// Private Struct - ShoppingCartItem
private struct ShoppingCartItemStruct {
    static let kProduct = "product"
    static let kQuantity = "quantity"
}

/// Shopping cart object, is handled by ShoppingCart, contains a product and a quantity of the same
class ShoppingCartItem : NSObject, NSCoding{
    
    
    /// Product object
    var product: Product = Product()
    
    /// Quantity of products
    var quantity: Int = 0
    
    /// Initializer
    ///
    /// - Parameter product: Product instance
    init(product: Product) {
        self.product = product
        self.quantity = 0
    }
    
    
    /// Adds one product to the quatity
    func addProduct(){
        self.quantity += 1
    }
    
    /// Removes a product of th
    func removeProduct(){
        if self.quantity > 0 {
            self.quantity -= 1
        }
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let product = aDecoder.decodeObject(forKey: ShoppingCartItemStruct.kProduct){
            self.product = product as! Product
            self.quantity = aDecoder.decodeInteger(forKey: ShoppingCartItemStruct.kQuantity)
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.quantity, forKey: ShoppingCartItemStruct.kQuantity)
        aCoder.encode(self.product, forKey: ShoppingCartItemStruct.kProduct)
    }
}
