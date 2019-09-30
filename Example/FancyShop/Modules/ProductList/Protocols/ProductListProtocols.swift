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

/// Method contract between PRESENTER -> VIEW
protocol ProductListViewProtocol: class {
    var presenter: ProductListPresenterProtocol? { get set }
    
    func showProducts(products: [Product])
    func showError(error: String)
    func showQuantityOfProductsInCartButton(quantity: Int)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol ProductListWireFrameProtocol: class {
    static func presentProductListModule(fromView: AnyObject)
    
    func presentSettingsModule()
    func presentConfirmOrderModule()
    func goToLogin()
}

/// Method contract between VIEW -> PRESENTER
protocol ProductListPresenterProtocol: class {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorInputProtocol? { get set }
    var wireFrame: ProductListWireFrameProtocol? { get set }
    
    func fetchProducts()
    func settingsAction()
    func addProductToShoppingCart(product: Product)
    func goToConfirmOrderAction()
    func configureShoppingCartButton()
    func goToLogin()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol ProductListInteractorOutputProtocol: class {
    
    func productsFetched(products:[Product])
    func showQuantityOfProducts(quantity: Int)
    func goToConfirmOrderModule()
    func showEmptyCartError()
    func showFetchProductsError()
}

/// Method contract between PRESENTER -> INTERACTOR
protocol ProductListInteractorInputProtocol: class
{
    var presenter: ProductListInteractorOutputProtocol? { get set }
    var APIDataManager: ProductListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ProductListLocalDataManagerInputProtocol? { get set }
    
    func fetchProducts()
    func addProductToShoppingCart(product: Product)
    func goToConfirmOrder()
    func configureShoppingCart()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol ProductListDataManagerInputProtocol: class{
    func getProducts() -> [Product]
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol ProductListAPIDataManagerInputProtocol: class{
    func fetchProductsFromServer(completionHandler: @escaping (NSDictionary?, Error?) -> ())
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol ProductListLocalDataManagerInputProtocol: class{
    
    func fetchLocalProducts(completionHandler: @escaping ([Product]?, Error?) -> ())
}
