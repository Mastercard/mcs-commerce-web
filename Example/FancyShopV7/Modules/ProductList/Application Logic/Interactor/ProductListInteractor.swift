//
//  ProductListInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Handles the product list interaction
class ProductListInteractor: ProductListInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: ProductListInteractorOutputProtocol?
    var APIDataManager: ProductListAPIDataManagerInputProtocol?
    var localDatamanager: ProductListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    
    /// Fetchs the products and pass them to the presenter
    func fetchProducts() {
        
    self.localDatamanager?.fetchLocalProducts(completionHandler: { (products, error) in
            
            if products != nil {
                
                self.presenter?.productsFetched(products: products!)
            } else {
                
                self.presenter?.showFetchProductsError()
            }
        })
        
//        //Getting the products from OneServer
//        self.APIDataManager?.fetchProductsFromServer(){ responseObject, error in
//            let status: String = responseObject?.value(forKey: "status") as! String
//            if status == Constants.status.OK{
//                self.presenter?.productsFetched(products: responseObject?.value(forKey:"products") as! [Product])
//            }else if status == Constants.status.NOK && error != nil{
//                self.presenter?.productsFetched(products: responseObject?.value(forKey:"products") as! [Product])
//                self.presenter?.showFetchProductsError()
//            }
//        }
    }
    
    
    /// Adds a product to the shopping cart
    ///
    /// - Parameter product: Product to add
    func addProductToShoppingCart(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.addProduct(product: product)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
    }
    
    /// Evaluates if all is ok to go the confirm order screen
    func goToConfirmOrder() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        if shoppingCart.getQuantityOfProductsInTheCart() > 0 {
            self.presenter?.goToConfirmOrderModule()
        }else{
            self.presenter?.showEmptyCartError()
        }
    }
    
    /// Passes the number of products in the cart to the presenter
    func configureShoppingCart() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
    }
}
