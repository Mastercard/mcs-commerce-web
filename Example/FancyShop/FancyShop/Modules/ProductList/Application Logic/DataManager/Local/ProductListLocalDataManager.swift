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
/// ProductListLocalDataManager implements the ProductListLocalDataManagerInputProtocol protocol, if data needs to be saved/retrieved locally, all the implentation should be done here
class ProductListLocalDataManager: ProductListLocalDataManagerInputProtocol {
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    /// Fetches the products from local
    ///
    /// - Parameter completionHandler: Block of code that will be executed after the request for products
    func fetchLocalProducts(completionHandler: @escaping ([Product]?, Error?) -> ()) {

        var products: [Product] = [Product]()
        
        let url = Bundle.main.path(forResource: "products", ofType: "json")
        let data = NSData(contentsOfFile: url!)
        if data != nil {
            
            do {
                let productsJSON = try JSONSerialization.jsonObject(with: data! as Data, options: []) as? [NSDictionary]
                
                for productJ: NSDictionary in productsJSON! {
                    let product: Product = Product.init()
                    product.productId = productJ.value(forKey: "productId") as! String
                    product.name = productJ.value(forKey: "name") as! String
                    product.price = productJ.value(forKey: "price") as! Double
                    product.salePrice = productJ.value(forKey: "salePrice") as! Double
                    product.imagePath = productJ.value(forKey: "image") as! String
                    product.productDescription = productJ.value(forKey: "description") as! String
                    product.dateAdded = productJ.value(forKey: "dateAdded") as! String
                    products.append(product)
                }
                
                completionHandler(products,nil);
            } catch let error as NSError {

                completionHandler(nil,error);
            }
        } else {
            
            completionHandler(nil,nil);
        }
    }
}
