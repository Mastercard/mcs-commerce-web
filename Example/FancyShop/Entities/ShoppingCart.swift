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

/// Private Struct - shoppingCart
private struct ShoppingCartKey {
    static let kItems = "items"
    static let kTotal = "total"
    static let kTaxes = "taxes"
    static let kSubtotal = "subtotal"
    static let kcartId = "cartId"
}

/// Shopping cart object, handles the shopping cart for purchase
class ShoppingCart: NSObject, NSCoding{
    //MARK: Variables
    
    /// ShoppingCartItem array
    var items: [ShoppingCartItem] = []
    
    /// Total of the cart, calculated with all the projects plus the taxes
    var total: Double = 0
    
    /// Taxes applied to the purchase
    var taxes: Double = 2.99
    
    /// Subtotal of the cart, calculated with all the projects
    var subtotal: Double = 0
    
    /// Cart Identifier, it's generated randomly if it does not exists
    var cartId: String = ""
    
    
    /// Singleton instance of the class
    static let sharedInstance : ShoppingCart = {
        if let instance = DataPersisterManager.sharedInstance.getShoppingCart() {
            return instance
        }
        return ShoppingCart()
    }()
    
    // MARK: Initializers
    
    /// Private initializer
    override private init() {
        self.items = []
        self.total = 0
        self.subtotal = 0
        self.cartId = ShoppingCart.getRandomCartId(length: 6)
    }
    
    //MARK: Methods
    
    /// Generates a random cart id, it will be used as order id after
    ///
    /// - Parameter length: card id length
    /// - Returns: Cart id
    fileprivate class func getRandomCartId(length: Int) -> String {
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    /// Adds a new product to the card
    ///
    /// - Parameter product: product to be added
    func addProduct(product: Product){
        self.getShoppingCartItemForProduct(product: product).addProduct()
        self.calculateValues()
        ShoppingCart.saveShoppingCart()
    }
    
    /// Removes a product of the cart
    ///
    /// - Parameter product: product to be removed
    func removeProduct(product: Product){
        let shoppingCartItem: ShoppingCartItem = self.getShoppingCartItemForProduct(product: product)
        shoppingCartItem.removeProduct()
        
        if shoppingCartItem.quantity == 0 {
            let itemToRemoveIndex = self.getIndexOfShoppingCartItem(shoppingCartItem: shoppingCartItem)
            if itemToRemoveIndex != -1{
                self.items.remove(at: itemToRemoveIndex)
            }
        }
        self.calculateValues()
        ShoppingCart.saveShoppingCart()
    }
    
    
    /// Removes all products and the item of the cart
    ///
    /// - Parameter product: product to be removed completely of the cart
    func removeAllProductsFromItem(product: Product){
        let shoppingCartItem: ShoppingCartItem = self.getShoppingCartItemForProduct(product: product)
        let itemToRemoveIndex = self.getIndexOfShoppingCartItem(shoppingCartItem: shoppingCartItem)
        if  itemToRemoveIndex != -1{
            self.items.remove(at: itemToRemoveIndex)
        }
        self.calculateValues()
        ShoppingCart.saveShoppingCart()
    }
    
    /// Calculates the number of products in the cart
    ///
    /// - Returns: Int, with the number of products
    func getQuantityOfProductsInTheCart() -> Int {
        var quantity = 0
        for forShoppingCartItem in self.items {
            quantity += forShoppingCartItem.quantity
        }
        return quantity
    }
    
    /// Returns the shopping cart item of a product
    ///
    /// - Parameter product: Product instance, used to get the shopping cart item
    /// - Returns: ShoppingCartItem
    fileprivate func getShoppingCartItemForProduct(product: Product) -> ShoppingCartItem{
        for shoppingCartItem in self.items {
            if shoppingCartItem.product.productId == product.productId{
                return shoppingCartItem
            }
        }
        let newShoppingCartItem: ShoppingCartItem = ShoppingCartItem.init(product: product)
        self.items.append(newShoppingCartItem)
        return newShoppingCartItem
    }
    
    
    /// Returns the index of a shopping cart item in the array
    ///
    /// - Parameter shoppingCartItem: shopping cart item to get the index
    /// - Returns: Index of the given ShoppingCartItem
    fileprivate func getIndexOfShoppingCartItem(shoppingCartItem: ShoppingCartItem) -> Int {
        var theIndex = 0
        for forShoppingCartItem in self.items {
            if forShoppingCartItem.product.productId == shoppingCartItem.product.productId{
                return theIndex;
            }
            theIndex += 1
        }
        return -1;
    }
    
    /// Calculates the values of the shopping cart, it's called after a product is added or removed of the cart
    func calculateValues(){
        self.calculateSubtotal()
    }
    
    /// Calculates the subtotal with all the products
    fileprivate func calculateSubtotal(){
        self.subtotal = 0
        for shoppingCartItem in self.items {
            self.subtotal += Double(shoppingCartItem.quantity) * shoppingCartItem.product.salePrice
        }
        self.subtotal = self.subtotal.roundToDecimal(2)
        self.calculateTotal()
    }
    
    /// Calculates the total, with the subtotal plus the taxes
    fileprivate func calculateTotal(){
        self.total = self.subtotal + self.taxes
        self.total = self.total.roundToDecimal(2)
    }
    
    
    /// Saves the shopping cart
    class func saveShoppingCart(){
        DataPersisterManager.sharedInstance.saveShoppingCart()
    }
    
    /// It empties the shopping cart
    func emptyCart(){
        self.items.removeAll()
        self.calculateValues()
    }
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let items = aDecoder.decodeObject(forKey:ShoppingCartKey.kItems){
            self.items = items as! [ShoppingCartItem]
            self.total = aDecoder.decodeDouble(forKey: ShoppingCartKey.kTotal)
            self.taxes = aDecoder.decodeDouble(forKey: ShoppingCartKey.kTaxes)
            self.subtotal = aDecoder.decodeDouble(forKey: ShoppingCartKey.kSubtotal)
            self.cartId = ShoppingCart.getRandomCartId(length: 6)
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.items, forKey: ShoppingCartKey.kItems)
        aCoder.encode(self.total, forKey: ShoppingCartKey.kTotal)
        aCoder.encode(self.taxes, forKey: ShoppingCartKey.kTaxes)
        aCoder.encode(self.subtotal, forKey: ShoppingCartKey.kSubtotal)
    }
}
