//
//  BasePresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/3/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Base presenter, has the common method implementations for all presenters
class BasePresenter {
    
    /// Gets a string from the given table and key
    ///
    /// - Parameters:
    ///   - key: key to get the string
    ///   - table: table from where to get the string
    /// - Returns: String with the message
    func localizedString(forKey key: String, fromTable table:String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: table)
    }
}
