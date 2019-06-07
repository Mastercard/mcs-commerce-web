//
//  CheckoutResponse.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/28/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation


/// CheckoutResponse object saves the status of the last AppToWeb checkout made
class CheckoutResponse : NSObject{
    
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
    static let sharedInstance : CheckoutResponse = CheckoutResponse()
    
    // MARK: Initializers
    /// Private initializer
    fileprivate override init() {
        super.init()
    }
}
