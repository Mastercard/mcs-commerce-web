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

/// Private Struct - Product
private struct productStruct {
    static let kProductId = "productId"
    static let kName = "name"
    static let kPrice = "price"
    static let kSalePrice = "salePrice"
    static let kImage = "imagePath"
    static let kDescription = "productDescription"
    static let kDateAdded = "dateAdded"
}

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
        if let productId = aDecoder.decodeObject(forKey:productStruct.kProductId){
            self.productId = productId as! String
            self.name = aDecoder.decodeObject(forKey: productStruct.kName) as! String
            self.price = aDecoder.decodeDouble(forKey: productStruct.kPrice)
            self.salePrice = aDecoder.decodeDouble(forKey: productStruct.kSalePrice)
            self.productDescription = aDecoder.decodeObject(forKey: productStruct.kDescription) as! String
            self.dateAdded = aDecoder.decodeObject(forKey: productStruct.kDateAdded) as! String
            self.imagePath = aDecoder.decodeObject(forKey: productStruct.kImage) as! String
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.productId, forKey: productStruct.kProductId)
        aCoder.encode(self.name, forKey: productStruct.kName)
        aCoder.encode(self.price, forKey: productStruct.kPrice)
        aCoder.encode(self.salePrice, forKey: productStruct.kSalePrice)
        aCoder.encode(self.productDescription, forKey: productStruct.kDescription)
        aCoder.encode(self.dateAdded, forKey: productStruct.kDateAdded)
        aCoder.encode(self.imagePath, forKey: productStruct.kImage)
    }
}
