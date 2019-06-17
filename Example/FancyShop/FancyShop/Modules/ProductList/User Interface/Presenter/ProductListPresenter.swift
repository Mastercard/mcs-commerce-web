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
