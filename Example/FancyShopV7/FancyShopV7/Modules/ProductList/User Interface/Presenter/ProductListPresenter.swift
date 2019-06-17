//
//  ProductListPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs

class ProductListPresenter:BasePresenter, ProductListPresenterProtocol, ProductListInteractorOutputProtocol {
    
    // MARK: variables
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorInputProtocol?
    var wireFrame: ProductListWireFrameProtocol?
    let stringsTableName = "ProductList"
    
    
    // MARK: ProductListPresenterProtocol
    
    /// Ask the interactor to fetch the products
    func fetchProducts(){
        self.interactor?.fetchProducts()
    }
    
    /// Goes to settings module
    func settingsAction(){
        self.wireFrame?.presentSettingsModule()
    }
    
    /// Adds a product to the cart
    ///
    /// - Parameter product: Product to add
    func addProductToShoppingCart(product: Product) {
        self.interactor?.addProductToShoppingCart(product: product)
    }
    
    /// Ask the interactor to check if it is ok to go to the confirm order module
    func goToConfirmOrderAction() {
        self.interactor?.goToConfirmOrder()
    }
    
    /// Ask the interactor to configure the shopping cart button
    func configureShoppingCartButton() {
        self.interactor?.configureShoppingCart()
    }
    
    // MARK: ProductListInteractorOutputProtocol
    
    /// Called after the products are fetched from the server
    ///
    /// - Parameter products: Product array
    func productsFetched(products: [Product]) {
        self.view?.showProducts(products: products)
    }
    
    /// Tells the view to show the number of products in the cart
    ///
    /// - Parameter quantity: Number of products
    func showQuantityOfProducts(quantity: Int) {
        self.view?.showQuantityOfProductsInCartButton(quantity: quantity)
    }
    
    /// Goes to confirm order module
    func goToConfirmOrderModule() {
        self.wireFrame?.presentConfirmOrderModule()
    }
    
    /// Shows an error when the user tries to go to confirm order without any product in the cart
    func showEmptyCartError() {
        self.view?.showError(error:super.localizedString(forKey: "EMPTY_CART_ERROR", fromTable: stringsTableName))
    }
    
    /// If something goes wrong while fetching the product list
    func showFetchProductsError() {
        self.view?.showError(error:super.localizedString(forKey: "GETTING_PRODUCTS_ERROR", fromTable: stringsTableName))
    }
    
    /// Goes to login module
    func goToLogin() {
        self.wireFrame?.goToLogin()
    }
}
