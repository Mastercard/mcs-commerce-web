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
import Alamofire

/// Private Struct - Product's detail
struct productAPIStruct {
    static let kProductId = "productId"
    static let kName = "name"
    static let kPrice = "price"
    static let kSalePrice = "salePrice"
    static let kImage = "image"
    static let kDescription = "description"
    static let kDateAdded = "dateAdded"
}

/// ProductListAPIDataManager implements the ProductListAPIDataManagerInputProtocol protocol, if data needs to be saved/retrieved from the server, all the implentation should be done here
class ProductListAPIDataManager: ProductListAPIDataManagerInputProtocol {
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    /// Fetches the products from OneServer
    ///
    /// - Parameter completionHandler: Block of code that will be executed after the request for products
    func fetchProductsFromServer(completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        Alamofire.request(OneServerRouter.getProducts).validate().responseJSON { response in
            var products: [Product] = [Product]()
            var responseDict: NSDictionary
            let responseKeys: [String] = ["status", "products"]
            switch response.result {
            case .success(let JSON):
                let productsJSON: [NSDictionary] = (JSON as! NSArray) as! [NSDictionary]
                for productJ: NSDictionary in productsJSON {
                    let product: Product = Product.init()
                    product.productId = productJ.value(forKey: productAPIStruct.kProductId) as! String
                    product.name = productJ.value(forKey: productAPIStruct.kName) as! String
                    product.price = productJ.value(forKey: productAPIStruct.kPrice) as! Double
                    product.salePrice = productJ.value(forKey: productAPIStruct.kSalePrice) as! Double
                    product.imagePath = productJ.value(forKey: productAPIStruct.kImage) as! String
                    product.productDescription = productJ.value(forKey: productAPIStruct.kDescription) as! String
                    product.dateAdded = productJ.value(forKey: productAPIStruct.kDateAdded) as! String
                    products.append(product)
                }
                responseDict = NSDictionary.init(objects: [Constants.status.OK, products], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, nil)
            case .failure(let error):
                responseDict = NSDictionary.init(objects: [Constants.status.NOK, products], forKeys: responseKeys as [NSCopying])
                completionHandler(responseDict, error)
            }
        }
    }
}
