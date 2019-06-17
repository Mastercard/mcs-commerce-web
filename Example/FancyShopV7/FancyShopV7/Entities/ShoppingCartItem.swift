//
//  ShoppingCartItem.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/8/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

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
        if self.quantity >= 0 {
            self.quantity -= 1
        }
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let product = aDecoder.decodeObject(forKey: "product"){
            self.product = product as! Product
            self.quantity = aDecoder.decodeInteger(forKey: "quantity")
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.quantity, forKey: "quantity")
        aCoder.encode(self.product, forKey: "product")
    }
}
