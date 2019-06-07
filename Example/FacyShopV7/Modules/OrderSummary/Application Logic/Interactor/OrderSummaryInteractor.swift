//
//  OrderSummaryInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import MCSCommerceWeb
/// OrderSummaryInteractor implements OrderSummaryInteractorInputProtocol protocol, handles the interaction to show the order summary and the right button to make the checkout
class OrderSummaryInteractor:BaseInteractor, OrderSummaryInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: OrderSummaryInteractorOutputProtocol?
    var APIDataManager: OrderSummaryAPIDataManagerInputProtocol?
    var localDatamanager: OrderSummaryLocalDataManagerInputProtocol?
    
    // MARK: OrderSummaryInteractorInputProtocol
    
    /// Handles the request to get the number of items on the cart
    func requestShoppingCartViewConfigurationHandler() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
    }
    
    /// Handles the request to get the items on the cart
    func getItemsOnShoppingCart() {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.set(shippingStatus: SDKConfiguration.sharedInstance.suppressShipping)
        self.callShoppingTotalizers()
    }
    
    /// Removes a product from the cart, if the product number is 0, it will go back to the product list
    ///
    /// - Parameter product: Product to remove
    func lessProductQuantity(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.removeProduct(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
        
        if shoppingCart.items.count == 0 {
            self.presenter?.goBackToProductList()
        }
    }
    
    
    /// Adds a product to the cart
    ///
    /// - Parameter product: Product to add
    func moreProductQuantity(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.addProduct(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
    }
    
    /// Removes a item from the cart
    ///
    /// - Parameter product: Product to remove
    func removeProductFromShoppingCart(product: Product) {
        let shoppingCart: ShoppingCart = ShoppingCart.sharedInstance
        shoppingCart.removeAllProductsFromItem(product: product)
        self.presenter?.itemsFetched(items: shoppingCart.items)
        self.presenter?.showQuantityOfProducts(quantity: shoppingCart.getQuantityOfProductsInTheCart())
        self.callShoppingTotalizers()
        
        if shoppingCart.items.count == 0 {
            self.presenter?.goBackToProductList()
        }
    }
    
    /// Evaluates if it has all the necessary data to make a expresscheckout, otherwise it will ask OneServer to get the pairing id
    func expressCheckout() {
        
        let user: User = User.sharedInstance
        if user.userHasPairingId() {
            self.presenter?.gottenPairingId()
        } else if user.userHasTransactionPairingId() {
            self.getPairingId()
        } else {
            let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
            if(configuration.enablePaymentMethodCheckout) {
                
                super.initiatePaymentMethodCheckout(completionHandler: { error in
                    DispatchQueue.main.async {
                        self.presenter?.showAddPaymentMethodAlert()
                    }
                })
            } else if configuration.enablePairingWithCheckout {
                //Web Pairing With Checkout
                MCCMerchant.pairing(withCheckout: true, merchantDelegate: MasterpassSDKManager.sharedInstance)
            }
        }
    }
    
    /// Evaluates the checkout flow to follow, if it has all the data and the configuration is enable, will go for a express checkout
    func getCheckoutFlow() {
        
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let user: User = User.sharedInstance
        if user.userHasTransactionPairingId() {
             self.presenter?.showExpressCheckoutFlow()
        } else {
            if NetworkReachability.isNetworkRechable() {
                self.presenter?.initializeSDK()
                super.initSDK(isPairingOnly: false, isExpressEnable: configuration.enableExpressCheckout) { responseObject, error in
                    
                    DispatchQueue.main.async {
                        self.presenter?.initializeSDKComplete()
                        let status: String = responseObject?.value(forKey: "status") as! String
                        if status == Constants.status.OK {
                            
                            if configuration.enablePaymentMethodCheckout {
                                self.presenter?.showPaymentMethodCheckoutFlow()
                            } else if configuration.enablePairingWithCheckout {
                                self.presenter?.showExpressCheckoutFlow()
                            } else {
                                self.presenter?.showMasterpassButtonCheckoutFlow()
                            }
                        } else if status == Constants.status.NOK && error != nil {
                            self.presenter?.showSDKInitializationError()
                        }
                    }
                }
            } else {
                self.presenter?.showNetworkError()
            }
        }
    }
    
    /// Passes the taxes, subtotal and total from the shopping cart
    fileprivate func callShoppingTotalizers(){
        let shoppingCart = ShoppingCart.sharedInstance
        self.presenter?.set(taxes: shoppingCart.taxes)
        self.presenter?.set(subtotal: shoppingCart.subtotal)
        self.presenter?.set(total: shoppingCart.total)
    }
    
    
    /// Calls OneServer to get the pairing Id using the transaction pairing id
    fileprivate func getPairingId(){
        if NetworkReachability.isNetworkRechable() {
            self.presenter?.gettingPairingId()
            self.APIDataManager?.getPairingId(){ response, error in
                let status: String = response?.value(forKey: "status") as! String
                if status == Constants.status.OK{
                    if let pairingId = response?.value(forKeyPath: "data.pairingId"){
                        let user:User = User.sharedInstance
                        user.pairingId = pairingId as? String
                        user.saveUser()
                        self.presenter?.gottenPairingId()
                    }else{
                        self.presenter?.showPairingIdError()
                    }
                }else{
                    self.presenter?.showPairingIdError()
                }
            }
        } else {
            self.presenter?.showNetworkError()
        }
    }
}
