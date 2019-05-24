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
protocol TransactionFailureViewProtocol: class {
    var presenter: TransactionFailurePresenterProtocol? { get set }
    func showQuantityOfProductsInCartButton(quantity: Int)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol TransactionFailureWireFrameProtocol: class {
    static func presentTransactionFailureModule(fromView view: AnyObject)
    func goBackToOrderSummery(animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol TransactionFailurePresenterProtocol: class {
    var view: TransactionFailureViewProtocol? { get set }
    var interactor: TransactionFailureInteractorInputProtocol? { get set }
    var wireFrame: TransactionFailureWireFrameProtocol? { get set }
    func goBackToOrderSummery(animated: Bool)
    func requestShoppingItemsConfigurationHandler()
}

/// Method contract between INTERACTOR -> PRESENTER
protocol TransactionFailureInteractorOutputProtocol: class {
    func showQuantityOfProducts(quantity: Int)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol TransactionFailureInteractorInputProtocol: class
{
    var presenter: TransactionFailureInteractorOutputProtocol? { get set }
    func requestShoppingItemsConfigurationHandler()
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol TransactionFailureDataManagerInputProtocol: class{
}
