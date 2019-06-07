//
//  ProductListLocalDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

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
