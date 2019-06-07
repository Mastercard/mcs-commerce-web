//
//  ProductListAPIDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import Alamofire
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
                    product.productId = productJ.value(forKey: "productId") as! String
                    product.name = productJ.value(forKey: "name") as! String
                    product.price = productJ.value(forKey: "price") as! Double
                    product.salePrice = productJ.value(forKey: "salePrice") as! Double
                    product.imagePath = productJ.value(forKey: "image") as! String
                    product.productDescription = productJ.value(forKey: "description") as! String
                    product.dateAdded = productJ.value(forKey: "dateAdded") as! String
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
