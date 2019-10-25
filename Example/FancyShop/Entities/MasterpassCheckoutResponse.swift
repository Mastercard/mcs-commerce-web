//
//  MasterpassCheckoutResponse.swift
//  FancyShop
//
//  Created by Ishar, Sahil on 10/14/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

import Foundation

class MasterpassCheckoutResponse: NSObject {

    //MARK: variables
    
    /// Cart id returned by the checkout
    var cartId: String?
    /// Resource URL returned by the checkout
    var checkoutResourceURL: String?
    /// Transaction id returned by the checkout
    /// It will be used for all the request made after the checkout
    var transactionId: String?
    /// Dictionary returned by the checkout
    var dictionary: NSDictionary?
    /// Error flag saved to show a message if needed
    var isError: Bool = false
    /// Error message saved to show if is needed
    var errorMessage: String?
    /// It will be used for get paringId
    var paringTransactionId: String?
    /// MARK: Singleton instance
    static let sharedInstance : MasterpassCheckoutResponse = MasterpassCheckoutResponse()
    
    // MARK: Initializers
    /// Private initializer
    fileprivate override init() {
        super.init()
    }
}
