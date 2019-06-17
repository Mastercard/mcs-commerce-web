//
//  Product.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/8/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Product Object, handles the product basic properties
class Product : NSObject, NSCoding{
    // MARK: Variables
    
    /// Product identifier
    var productId: String = ""
    
    /// Product name
    var name: String = ""
    
    /// Product normal price
    var price: Double = 0
    
    /// Product sale price
    var salePrice: Double = 0
    
    /// Product description
    var productDescription: String = ""
    
    /// Product date when it was added
    var dateAdded: String = ""
    
    /// Product Image path on the server
    var imagePath: String = ""
    
    /// Product Image URL
    var image: String {
        return Constants.server.baseURL + imagePath
    }

    //MARK: Initializers
    /// Base Initializer
    override init() {
        super.init()
    }
    
    /// Full Initializer, receives all parameters
    ///
    /// - Parameters:
    ///   - productId: Product Id
    ///   - name: Product Name
    ///   - price: Product price
    ///   - salePrice: Product sale price
    ///   - image: Product Image (path)
    ///   - description: Product Description
    ///   - dateAdded: Product date added to the catalog
    init(productId: String, name: String, price: Double, salePrice: Double, image: String, description: String, dateAdded: String) {
        super.init()
        self.productId = productId
        self.name = name
        self.price = price
        self.salePrice = salePrice
        self.productDescription = description
        self.dateAdded = dateAdded
        self.imagePath = image
    }
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let productId = aDecoder.decodeObject(forKey:"productId"){
            self.productId = productId as! String
            self.name = aDecoder.decodeObject(forKey: "name") as! String
            self.price = aDecoder.decodeDouble(forKey: "price")
            self.salePrice = aDecoder.decodeDouble(forKey: "salePrice")
            self.productDescription = aDecoder.decodeObject(forKey: "productDescription") as! String
            self.dateAdded = aDecoder.decodeObject(forKey: "dateAdded") as! String
            self.imagePath = aDecoder.decodeObject(forKey: "imagePath") as! String
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.productId, forKey: "productId")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.price, forKey: "price")
        aCoder.encode(self.salePrice, forKey: "salePrice")
        aCoder.encode(self.productDescription, forKey: "productDescription")
        aCoder.encode(self.dateAdded, forKey: "dateAdded")
        aCoder.encode(self.imagePath, forKey: "imagePath")
    }
}
